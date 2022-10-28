(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage'        Copyright (c) 2021                    *)
(*                                                                        *)
(*                                  Lucas Moura Belo - lmbelo             *)
(*                                  lucas.belo@live.com                   *)
(*                                  Brazil                                *)
(*                                                                        *)
(*  Project page:                   https://github.com/lmbelo/P4D_AI_ML   *)
(**************************************************************************)
(*  Functionality:  PyPackage layer                                       *)
(*                                                                        *)
(*                                                                        *)
(**************************************************************************)
(* This source code is distributed with no WARRANTY, for no reason or use.*)
(* Everyone is allowed to use and change this code free for his own tasks *)
(* and projects, as long as this header and its copyright text is intact. *)
(* For changed versions of this code, which are public distributed the    *)
(* following additional conditions have to be fullfilled:                 *)
(* 1) The header has to contain a comment on the change and the author of *)
(*    it.                                                                 *)
(* 2) A copy of the changed source has to be sent to the above E-Mail     *)
(*    address or my then valid address, if this is possible to the        *)
(*    author.                                                             *)
(* The second condition has the target to maintain an up to date central  *)
(* version of the component. If this condition is not acceptable for      *)
(* confidential or legal reasons, everyone is free to derive a component  *)
(* or to generate a diff file to my or other original sources.            *)
(**************************************************************************)
unit PyPackage;

interface

uses
  System.Rtti,
  System.Types,
  System.Classes,
  System.SysUtils,
  System.Threading,
  System.Generics.Collections,
  PyTools.Cancelation,
  PyEnvironment,
  PyCore,
  PyCommon,
  PyModule,
  PyPackage.Model,
  PyPackage.Manager.ManagerKind,
  PyPackage.Manager.Managers,
  PyPackage.Manager.Intf,
  PyPackage.Manager.Defs;

type
  (*----------------------------------------------------------------------------*)
  (*                                                                            *)
  (*                      Packages structure example                            *)
  (*                                                                            *)
  (* ref: https://docs.python.org/3/tutorial/modules.html                       *)
  (*                                                                            *)
  (*                                                                            *)
  (* dir                                                                        *)
  (*  +-- sound/                         Top-level package                      *)
  (*       +-- __init__.py               Initialize the sound package           *)
  (*       +-- formats/                  Subpackage for file format conversions *)
  (*            +-- __init__.py                                                 *)
  (*            +-- wavread.py           wavread module                         *)
  (*            +-- wavwrite.py          wavwrite module                        *)
  (*            +-- ...                                                         *)
  (*       +-- effects/                  Subpackage for sound effects           *)
  (*            +-- __init__.py                                                 *)
  (*            +-- echo.py              echo module                            *)
  (*            +-- surround.py          surround module                        *)
  (*            +-- ...                                                         *)
  (*       +-- filters/                  Subpackage for filters                 *)
  (*            +-- __init__.py                                                 *)
  (*            +-- equalizer.py         qualizer module                        *)
  (*            +-- vocoder.py           vocoder module                         *)
  (*            +-- ...                                                         *)
  (*----------------------------------------------------------------------------*)
  TPyPackageBase = class(TPyModuleBase)
  private
    FSubPackages: TDictionary<TPyPackageName, TPyPackageBase>;
    FModules: TDictionary<TPyModuleName, TPyModuleBase>;
    //Get methods
    function GetModule(const AName: TPyModuleName): TPyModuleBase;
    function GetSubPackage(const AName: TPyPackageName): TPyPackageBase;
  protected
    //Virtual methods
    function CreateSubPackage(const AName: TPyPackageName): TPyPackageBase; virtual;
    function CreateModule(const AName: TPyModuleName): TPyModuleBase; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    function IsSubPackage(): boolean;

    property PySubPackage[const AName: TPyPackageName]: TPyPackageBase read GetSubPackage;
    property PyModule[const AName: TPyModuleName]: TPyModuleBase read GetModule;
  end;

  //Non-managed package
  TPyPackage = class(TPyPackageBase)
  published
    property PythonEngine;
  end;

  //Managed package
  TOnInstallPackageError = procedure(Sender: TObject; AException: Exception; var AAbort: boolean) of object;
  TOnUninstallpackageError = procedure(Sender: TObject; AException: Exception; var AAbort: boolean) of object;

  TPyManagedPackage = class abstract(TPyPackageBase, IPyEnvironmentPlugin)
  private type
    TPyManagedPackageState = (Installed, NotInstalled, Imported);
    TPyManagedPackageStates = set of TPyManagedPackageState;

    TPyManagers = class(TPersistent)
    private
      FModel: TPyPackageModel;
      function GetConda: TPyPackageManagerDefs;
      function GetPip: TPyPackageManagerDefs;
      procedure SetConda(const Value: TPyPackageManagerDefs);
      procedure SetPip(const Value: TPyPackageManagerDefs);
    public
      constructor Create(const AModel: TPyPackageModel);
    published
      property Pip: TPyPackageManagerDefs read GetPip write SetPip;
      property Conda: TPyPackageManagerDefs read GetConda write SetConda;
    end;
  private
    FModel: TPyPackageModel;
    FManagerKind: TPyPackageManagerKind;
    FManagers: TPyManagers;
    FAutoInstall: boolean;
    FState: TPyManagedPackageStates;
    //Events
    FBeforeInstall: TNotifyEvent;
    FOnInstallError: TOnInstallPackageError;
    FAfterInstall: TNotifyEvent;
    FBeforeUninstall: TNotifyEvent;
    FOnUninstallError: TOnUninstallpackageError;
    FAfterUninstall: TNotifyEvent;
    //Getters and Setters
    procedure SetManagers(const Value: TPyManagers);
    function GetInfo(): TPyPluginInfo;
    //Internal delegations
    procedure InternalInstall(const ACancelation: ICancelation);
    procedure InternalUninstall(const ACancelation: ICancelation);
    //Throw errors
    procedure RaiseNotInstalled;
    //Utils
    function GetPackageManager(const AManagerKind: TPyPackageManagerKind): IPyPackageManager;
    //Event handlers
    procedure DoBeforeInstall;
    procedure DoAfterInstall;
    procedure DoInstallError();
    procedure DoBeforeUninstall();
    procedure DoAfterUninstall();
    procedure DoUninstallError();
  protected
    procedure DoAutoLoad(); override;
    function GetPyModuleName(): string; override;
    procedure SetPyEnvironment(const APyEnvironment: TPyEnvironment); override;
    //IPyEnvironmentPlugin implementation
    procedure InstallPlugin(const ACancelation: ICancelation);
    procedure UninstallPlugin(const ACancelation: ICancelation);
    procedure LoadPlugin(const ACancelation: ICancelation);
    procedure UnloadPlugin(const ACancelation: ICancelation);
    function IsInstalled(): boolean; inline;
  protected
    procedure Prepare(const AModel: TPyPackageModel); virtual; abstract;
  protected
    procedure CheckInstalled();
    procedure InstallPackage(const ACancelation: ICancelation); virtual;
    procedure UninstallPackage(const ACancelation: ICancelation); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    //Setup routines
    procedure Install(); overload;
    procedure Uninstall(); overload;
  published
    property PythonEngine;
    property PyEnvironment;
    property ManagerKind: TPyPackageManagerKind read FManagerKind write FManagerKind;
    property Managers: TPyManagers read FManagers write SetManagers;
    property AutoInstall: boolean read FAutoInstall write FAutoInstall default true;
    //Installation events
    property BeforeInstall: TNotifyEvent read FBeforeInstall write FBeforeInstall;
    property OnInstallError: TOnInstallPackageError read FOnInstallError write FOnInstallError;
    property AfterInstall: TNotifyEvent read FAfterInstall write FAfterInstall;
    //Uninstallation events
    property BeforeUninstall: TNotifyEvent read FBeforeUninstall write FBeforeUninstall;
    property OnUninstallError: TOnUninstallpackageError read FOnUninstallError write FOnUninstallError;
    property AfterUninstall: TNotifyEvent read FAfterUninstall write FAfterUninstall;
  end;

implementation

uses
  System.Variants,
  PythonEngine, VarPyth,
  PyExceptions;

type
  TPyAnonymousPackage = class(TPyPackageBase)
  private
    FPyPackageName: TPyPackageName;
    FPyParent: TPyModuleBase;
  protected
    function GetPyModuleName(): string; override;
    function GetPyParent(): TPyModuleBase; override;
  public
    constructor Create(const AName: TPyPackageName; const AParent: TPyModuleBase); reintroduce;
  end;

  TPyAnonymousModule = class(TPyModuleBase)
  private
    FPyModuleName: TPyModuleName;
    FPyParent: TPyModuleBase;
  protected
    function GetPyModuleName(): string; override;
    function GetPyParent(): TPyModuleBase; override;
  public
    constructor Create(const AName: TPyModuleName; const AParent: TPyModuleBase); reintroduce;
  end;

{ TPyPackageBase }

constructor TPyPackageBase.Create(AOwner: TComponent);
begin
  inherited;
  FSubPackages := TDictionary<TPyPackageName, TPyPackageBase>.Create();
  FModules := TDictionary<TPyModuleName, TPyModuleBase>.Create();
end;

function TPyPackageBase.CreateModule(const AName: TPyModuleName): TPyModuleBase;
begin
  Result := TPyAnonymousModule.Create(AName, Self);
  Result.PythonEngine := PythonEngine;
end;

function TPyPackageBase.CreateSubPackage(
  const AName: TPyPackageName): TPyPackageBase;
begin
  Result := TPyAnonymousPackage.Create(AName, Self);
  Result.PythonEngine := PythonEngine;
end;

destructor TPyPackageBase.Destroy;
begin
  FModules.Free();
  FSubPackages.Free();
  inherited;
end;

function TPyPackageBase.GetModule(const AName: TPyModuleName): TPyModuleBase;
begin
  FModules.TryGetValue(AName, Result);
  if not Assigned(Result) then begin
    Result := CreateModule(AName);
    FModules.Add(AName, Result);
  end;
end;

function TPyPackageBase.GetSubPackage(
  const AName: TPyPackageName): TPyPackageBase;
begin
  FSubPackages.TryGetValue(AName, Result);
  if not Assigned(Result) then begin
    Result := CreateSubPackage(AName);
    FSubPackages.Add(AName, Result);
  end;
end;

function TPyPackageBase.IsSubPackage: boolean;
begin
  Result := Assigned(PyParent);
end;

{ TPyAnonymousPackage }

constructor TPyAnonymousPackage.Create(const AName: TPyPackageName;
  const AParent: TPyModuleBase);
begin
  inherited Create(AParent);
  FPyParent := AParent;
  FPyPackageName := AName;
end;

function TPyAnonymousPackage.GetPyModuleName: string;
begin
  Result := FPyPackageName;
end;

function TPyAnonymousPackage.GetPyParent: TPyModuleBase;
begin
  Result := FPyParent;
end;

{ TPyAnonymousModule }

constructor TPyAnonymousModule.Create(const AName: TPyModuleName;
  const AParent: TPyModuleBase);
begin
  inherited Create(AParent);
  FPyParent := AParent;
  FPyModuleName := AName;
end;

function TPyAnonymousModule.GetPyModuleName: string;
begin
  Result := FPyModuleName;
end;

function TPyAnonymousModule.GetPyParent: TPyModuleBase;
begin
  Result := FPyParent;
end;

{ TPyManagedPackage }

constructor TPyManagedPackage.Create(AOwner: TComponent);
begin
  inherited;
  FState := [];
  FAutoInstall := true;
  FModel := TPyPackageModel.Create();
  FManagers := TPyManagers.Create(FModel);
  Prepare(FModel);
end;

procedure TPyManagedPackage.DoAutoLoad;
begin
  if not Assigned(PyEnvironment) and FAutoInstall then
    Install();
  inherited;
end;

destructor TPyManagedPackage.Destroy;
begin
  FManagers.Free();
  FModel.Free();
  inherited;
end;

procedure TPyManagedPackage.SetManagers(const Value: TPyManagers);
begin
  FManagers.Assign(Value);
end;

procedure TPyManagedPackage.SetPyEnvironment(
  const APyEnvironment: TPyEnvironment);
begin
  if not (csDesigning in ComponentState) then
    if (APyEnvironment <> PyEnvironment) then begin
      if Assigned(PyEnvironment) then begin
        PyEnvironment.RemovePlugin(Self);
      end;

      if Assigned(APyEnvironment) then begin
        APyEnvironment.AddPlugin(Self);
      end;
    end;

  inherited;
end;

function TPyManagedPackage.GetPackageManager(
  const AManagerKind: TPyPackageManagerKind): IPyPackageManager;
begin
  if not FModel.PackageManagers.ContainsKey(AManagerKind) then
    raise EManagerUnavailable.CreateFmt('%s manager unavailable for package %s', [
      AManagerKind.ToString(), GetPyModuleName()]);

  Result := FModel.PackageManagers.Items[AManagerKind];
end;

function TPyManagedPackage.GetPyModuleName: string;
begin
  Result := FModel.PackageName;
end;

procedure TPyManagedPackage.Install;
var
  LCancelation: ICancelation;
begin
  LCancelation := TCancelation.Create();
  InstallPackage(LCancelation);
end;

procedure TPyManagedPackage.Uninstall;
var
  LCancelation: ICancelation;
begin
  LCancelation := TCancelation.Create();
  UnInstallPackage(LCancelation);
end;

function TPyManagedPackage.IsInstalled: boolean;
begin
  //Avoid creating subprocess
  if (TPyManagedPackageState.Installed in FState) then
    Result := true
  else if (TPyManagedPackageState.NotInstalled in FState) then
    Result := false
  else begin
    Result := GetPackageManager(ManagerKind).IsInstalled();
    if Result then
      Include(FState, TPyManagedPackageState.Installed)
    else
      Include(FState, TPyManagedPackageState.NotInstalled);
  end;
end;

procedure TPyManagedPackage.DoAfterInstall;
begin
  if Assigned(FAfterInstall) then
    TThread.Synchronize(nil, procedure() begin
      FAfterInstall(Self);
    end);
end;

procedure TPyManagedPackage.DoBeforeInstall;
begin
  if Assigned(FBeforeInstall) then
    TThread.Synchronize(nil, procedure() begin
      FBeforeInstall(Self);
    end);
end;

procedure TPyManagedPackage.DoInstallError();
var
  LAbort: Boolean;
  LException: Exception;
begin
  if Assigned(FOnInstallError) then begin
    LAbort := true;
    LException := Exception(ExceptObject);
    TThread.Synchronize(nil, procedure() begin
      FOnInstallError(Self, LException, LAbort);
    end);

    if LAbort then
      Abort();
  end else begin
    try
      raise Exception(AcquireExceptionObject()) at ExceptAddr;
    finally
      ReleaseExceptionObject();
    end;
  end;
end;

procedure TPyManagedPackage.DoBeforeUninstall;
begin
  if Assigned(FBeforeUninstall) then
    TThread.Synchronize(nil, procedure() begin
      FBeforeUninstall(Self);
    end);
end;

procedure TPyManagedPackage.DoAfterUninstall;
begin
  if Assigned(FAfterUninstall) then
    TThread.Synchronize(nil, procedure() begin
      FAfterUninstall(Self);
    end);
end;

procedure TPyManagedPackage.DoUninstallError;
var
  LAbort: Boolean;
  LException: Exception;
begin
  if Assigned(FOnUninstallError) then begin
    LAbort := true;
    LException := Exception(ExceptObject);
    TThread.Synchronize(nil, procedure() begin
      FOnUnInstallError(Self, LException, LAbort);
    end);

    if LAbort then
      Abort();
  end else begin
    try
      raise Exception(AcquireExceptionObject()) at ExceptAddr;
    finally
      ReleaseExceptionObject();
    end;
  end;
end;

procedure TPyManagedPackage.RaiseNotInstalled;
begin
  raise EPyPackageNotInstalled.CreateFmt(ErrPackageNotInstalled, [GetPyModuleName]);
end;

procedure TPyManagedPackage.CheckInstalled;
begin
  if IsReady() and not IsInstalled() then
    RaiseNotInstalled();
end;

procedure TPyManagedPackage.InternalInstall(const ACancelation: ICancelation);
begin
  GetPackageManager(ManagerKind).Install(ACancelation);
end;

procedure TPyManagedPackage.InternalUninstall(const ACancelation: ICancelation);
begin
  GetPackageManager(ManagerKind).Uninstall(ACancelation);
end;

procedure TPyManagedPackage.InstallPackage(const ACancelation: ICancelation);
begin
  if IsReady() and not IsInstalled() then begin
    DoBeforeInstall();
    try
      InternalInstall(ACancelation);
      Exclude(FState, TPyManagedPackageState.NotInstalled);
      Include(FState, TPyManagedPackageState.Installed);
      DoAfterInstall();
    except
      on E: EAbort do
        raise
      else
        DoInstallError();
    end;
  end;
end;

procedure TPyManagedPackage.UninstallPackage(const ACancelation: ICancelation);
begin
  if IsReady() then
    if IsInstalled() then begin
      DoBeforeUninstall();
      try
        InternalUninstall(ACancelation);
        Exclude(FState, TPyManagedPackageState.Installed);
        Include(FState, TPyManagedPackageState.NotInstalled);
        DoAfterUninstall();
      except
        on E: EAbort do
          raise
        else
          DoUninstallError();
      end;
    end else
      RaiseNotInstalled();
end;

function TPyManagedPackage.GetInfo: TPyPluginInfo;
begin
  Result.Name := PyModuleName;
  Result.Description := Format('Python module "%s" for Delphi.', [PyModuleName]);
  Result.InstallsWhen := [TPyPluginEvent.AfterActivate];
  Result.LoadsWhen := [TPyPluginEvent.AfterActivate];
end;

procedure TPyManagedPackage.InstallPlugin(const ACancelation: ICancelation);
begin
  Assert(Assigned(ACancelation), 'Invalid argument "ACancelation".');

  if AutoInstall then
    InstallPackage(ACancelation);
end;

procedure TPyManagedPackage.UninstallPlugin(const ACancelation: ICancelation);
begin
  Assert(Assigned(ACancelation), 'Invalid argument "ACancelation".');

  UninstallPackage(ACancelation);
end;

procedure TPyManagedPackage.LoadPlugin(const ACancelation: ICancelation);
begin
  Assert(Assigned(ACancelation), 'Invalid argument "ACancelation".');

  if AutoImport and CanImport() then
    TThread.Synchronize(nil, procedure() begin
      Import();
    end);
end;

procedure TPyManagedPackage.UnloadPlugin(const ACancelation: ICancelation);
begin
  Assert(Assigned(ACancelation), 'Invalid argument "ACancelation".');
end;

{ TPyManagedPackage.TPyManagers }

constructor TPyManagedPackage.TPyManagers.Create(const AModel: TPyPackageModel);
begin
  FModel := AModel;
end;

function TPyManagedPackage.TPyManagers.GetConda: TPyPackageManagerDefs;
begin
  if FModel.PackageManagers.ContainsKey(TPyPackageManagerKind.conda) then
    Result := FModel.PackageManagers.Items[TPyPackageManagerKind.conda].Defs
  else
    Result := nil;
end;

function TPyManagedPackage.TPyManagers.GetPip: TPyPackageManagerDefs;
begin
  if FModel.PackageManagers.ContainsKey(TPyPackageManagerKind.pip) then
    Result := FModel.PackageManagers.Items[TPyPackageManagerKind.pip].Defs
  else
    Result := nil;
end;

procedure TPyManagedPackage.TPyManagers.SetConda(
  const Value: TPyPackageManagerDefs);
begin
  if FModel.PackageManagers.ContainsKey(TPyPackageManagerKind.conda) then
    FModel.PackageManagers.Items[TPyPackageManagerKind.conda].Defs.Assign(Value);
end;

procedure TPyManagedPackage.TPyManagers.SetPip(
  const Value: TPyPackageManagerDefs);
begin
  if FModel.PackageManagers.ContainsKey(TPyPackageManagerKind.pip) then
    FModel.PackageManagers.Items[TPyPackageManagerKind.pip].Defs.Assign(Value);
end;

end.

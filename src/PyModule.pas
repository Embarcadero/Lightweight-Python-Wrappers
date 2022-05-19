(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyModule'    Copyright (c) 2021                         *)
(*                                                                        *)
(*                                  Lucas Moura Belo - lmbelo             *)
(*                                  lucas.belo@live.com                   *)
(*                                  Brazil                                *)
(*                                                                        *)
(*  Project page:                https://github.com/lmbelo/P4D_AI_ML      *)
(**************************************************************************)
(*  Functionality:  PyModule layer                                        *)
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
unit PyModule;

interface

uses
  System.Classes, System.Generics.Collections, System.SysUtils, System.Rtti,
  PythonEngine, PyCommon, PyCore;

type
  TPyModuleBase = class(TPyCommonCustomModule)
  private
    FAutoImport: boolean;
    FBeforeImport: TNotifyEvent;
    FAfterImport: TNotifyEvent;
  protected
    //Get methods
    function GetPyModuleName(): string; virtual; abstract;
    function GetPyParent(): TPyModuleBase; virtual;
    //Internal routines
    procedure Loaded; override;
    //Desing-time actions
    procedure DoAutoLoad(); virtual;
    //Module routines
    procedure EngineLoaded(); override;
    function CanImport(): boolean;
    procedure ImportModule(); reintroduce; virtual;
    procedure CheckImported();
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    //Module import routines
    function IsImported(): boolean;
    procedure Import();
    //Helper methods
    function AsVariant(): variant;
  public
    property PyParent: TPyModuleBase read GetPyParent;
  published
    property PyModuleName: string read GetPyModuleName;
    property AutoImport: boolean read FAutoImport write FAutoImport default true;
    //Events
    property BeforeImport: TNotifyEvent read FBeforeImport write FBeforeImport;
    property AfterImport: TNotifyEvent read FAfterImport write FAfterImport;
  end;

  TPyModule = class(TPyModuleBase)
  end;

implementation

uses
  PyExceptions, VarPyth;

{ TPyModuleBase }

procedure TPyModuleBase.CheckImported;
begin
  if not IsImported() then
    raise EPyModuleNotImported.Create(ErrModuleNotImported);
end;

constructor TPyModuleBase.Create(AOwner: TComponent);
begin
  inherited;
  FAutoImport := true;
end;

procedure TPyModuleBase.DoAutoLoad;
begin
  if FAutoImport and CanImport() then
    Import();
end;

destructor TPyModuleBase.Destroy;
begin
  inherited;
end;

procedure TPyModuleBase.EngineLoaded;
begin
  inherited;
  if FAutoImport and CanImport() then
    Import();
end;

function TPyModuleBase.GetPyParent: TPyModuleBase;
begin
  Result := nil;
end;

function TPyModuleBase.AsVariant: variant;
begin
  CheckImported();
  Result := VarPythonCreate(PyModuleRef);
end;

function TPyModuleBase.CanImport: boolean;
begin
  Result := not (csDesigning in ComponentState)
    and Assigned(PythonEngine)
    and PythonEngine.Initialized
    and not IsImported();
end;

procedure TPyModuleBase.Import;
begin
  ImportModule();
end;

function TPyModuleBase.IsImported: boolean;
begin
  Result := Assigned(PyModuleRef);
end;

procedure TPyModuleBase.ImportModule;
var
  LImport: string;
  LPyParent: TPyModuleBase;
begin
  if Assigned(FBeforeImport) then
    FBeforeImport(Self);

  LImport := PyModuleName;
  LPyParent := PyParent;
  while Assigned(LPyParent) do begin
    LImport := LPyParent.PyModuleName + '.' + LImport;
    LPyParent := LPyParent.PyParent;
  end;
  inherited ImportModule(LImport);

  if Assigned(FAfterImport) then
    FAfterImport(Self);
end;

procedure TPyModuleBase.Loaded;
begin
  inherited;
  DoAutoLoad();
end;

end.

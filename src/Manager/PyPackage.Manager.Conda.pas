(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Conda'                                *)
(*                                                                        *)
(*                                  Copyright (c) 2021                    *)
(*                                  Lucas Moura Belo - lmbelo             *)
(*                                  lucas.belo@live.com                   *)
(*                                  Brazil                                *)
(*                                                                        *)
(*  Project page:                   https://github.com/lmbelo/P4D_AI_ML   *)
(**************************************************************************)
(*  Functionality:  PyPackage Manager layer                               *)
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
unit PyPackage.Manager.Conda;

interface

uses
  PyCore,
  PyPackage.Manager,
  PyPackage.Manager.Intf,
  PyPackage.Manager.Defs,
  PyPackage.Manager.Cmd.Intf,
  PyPackage.Manager.Defs.Opts.Conda.List;

type
  TPyPackageManagerConda = class(TPyPackageManager, IPyPackageManager)
  private
    FDefs: TPyPackageManagerDefs;
    FCmd: IPyPackageManagerCmdIntf;
    //Builders
    function BuildOptsList(): TPyPackageManagerDefsOptsCondaList;
    //IPyPackageManager implementation
    function GetDefs(): TPyPackageManagerDefs;
    function GetCmd(): IPyPackageManagerCmdIntf;
    function IsInstalled(out AInstalled: boolean; out AOutput: string): boolean; reintroduce;
    function Install(out AOutput: string): boolean;
    function Uninstall(out AOutput: string): boolean;
  public
    constructor Create(const APackageName: TPyPackageName); override;
    destructor Destroy; override;
  end;

implementation

uses
  System.Variants, System.SysUtils,
  PythonEngine, VarPyth,
  PyUtils, PyExceptions,
  PyPackage.Manager.Defs.Conda,
  PyPackage.Manager.Cmd.Conda;

{ TPyPackageManagerConda }

function TPyPackageManagerConda.BuildOptsList: TPyPackageManagerDefsOptsCondaList;
begin
  Result := TPyPackageManagerDefsOptsCondaList.Create();
  try
    Result.Name := (FDefs as TPyPackageManagerDefsConda).InstallOptions.Name;
    Result.Prefix := (FDefs as TPyPackageManagerDefsConda).InstallOptions.Prefix;
  except
    on E: Exception do begin
      Result.Free();
      raise;
    end;
  end;
end;

constructor TPyPackageManagerConda.Create(const APackageName: TPyPackageName);
begin
  inherited;
  FDefs := TPyPackageManagerDefsConda.Create(APackageName);
  FCmd := TPyPackageManagerCmdConda.Create(FDefs);
end;

destructor TPyPackageManagerConda.Destroy;
begin
  inherited;
  FCmd := nil;
  FDefs.Free();
end;

function TPyPackageManagerConda.GetCmd: IPyPackageManagerCmdIntf;
begin
  Result := FCmd;
end;

function TPyPackageManagerConda.GetDefs: TPyPackageManagerDefs;
begin
  Result := FDefs;
end;

function TPyPackageManagerConda.IsInstalled(out AInstalled: boolean; out AOutput: string): boolean;
begin
  //Will be changed to run on a separeted process
  var LOpts := BuildOptsList();
  try
    var LIn := FCmd.BuildListCmd(LOpts);
    var LConda := Import('conda.cli');
    var LResult := LConda.main('conda', TPyEx.List<String>(LIn), FDefs.PackageName);
  finally
    LOpts.Free();
  end;
  Result := false;
end;

function TPyPackageManagerConda.Install(out AOutput: string): boolean;
begin
  //Will be changed to run on a separeted process
  var LIn := FCmd.BuildInstallCmd((FDefs as TPyPackageManagerDefsConda).InstallOptions);
  var LConda := Import('conda.cli');
  var LResult := LConda.main('conda', TPyEx.List<String>(LIn), , FDefs.PackageName);
  Result := LResult = 0;
  AOutput := String.Empty;
end;

function TPyPackageManagerConda.Uninstall(out AOutput: string): boolean;
begin
  //Will be changed to run on a separeted process
  var LIn := FCmd.BuildUninstallCmd((FDefs as TPyPackageManagerDefsConda).UninstallOptions);
  var LConda := Import('conda.cli');
  var LResult := LConda.main('conda', TPyEx.List<String>(LIn), FDefs.PackageName);
  Result := LResult = 0;
  AOutput := String.Empty;
end;

end.

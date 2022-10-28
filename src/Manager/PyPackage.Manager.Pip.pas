(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Pip'                                  *)
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
unit PyPackage.Manager.Pip;

interface

uses
  PyTools.ExecCmd,
  PyTools.ExecCmd.Args,
  PyTools.Cancelation,
  PyCore,
  PyPackage,
  PyPackage.Manager,
  PyPackage.Manager.Intf,
  PyPackage.Manager.Defs,
  PyPackage.Manager.Cmd.Intf,
  PyPackage.Manager.Defs.Opts.Pip.List;

type
  TPyPackageManagerPip = class(TPyPackageManager, IPyPackageManager)
  private
    FDefs: TPyPackageManagerDefs;
    FCmd: IPyPackageManagerCmdIntf;
    //Builders
    function BuildOptsList(): TPyPackageManagerDefsOptsPipList;
    //IPyPackageManager implementation
    function GetDefs(): TPyPackageManagerDefs;
    function GetCmd(): IPyPackageManagerCmdIntf;
    function IsInstalled(): boolean;
    procedure Install(const ACancelation: ICancelation);
    procedure Uninstall(const ACancelation: ICancelation);
  public
    constructor Create(const APackageName: TPyPackageName); override;
    destructor Destroy; override;
  end;

implementation

uses
  System.Variants, System.SysUtils, System.IOUtils, System.Generics.Collections,
  PythonEngine,
  PyUtils,
  PyExceptions,
  PyPackage.Manager.Defs.Pip,
  PyPackage.Manager.Cmd.Pip, System.SyncObjs;

{ TPyPackageManagerPip }

constructor TPyPackageManagerPip.Create(const APackageName: TPyPackageName);
begin
  inherited;
  FDefs := TPyPackageManagerDefsPip.Create(APackageName);
  FCmd := TPyPackageManagerCmdPip.Create(FDefs);
end;

destructor TPyPackageManagerPip.Destroy;
begin
  FCmd := nil;
  FDefs.Free();
  inherited;
end;

function TPyPackageManagerPip.GetCmd: IPyPackageManagerCmdIntf;
begin
  Result := FCmd;
end;

function TPyPackageManagerPip.GetDefs: TPyPackageManagerDefs;
begin
  Result := FDefs;
end;

function TPyPackageManagerPip.BuildOptsList: TPyPackageManagerDefsOptsPipList;
begin
  Result := TPyPackageManagerDefsOptsPipList.Create();
  try
    Result.User := (FDefs as TPyPackageManagerDefsPip).InstallOptions.User;
  except
    on E: Exception do begin
      Result.Free();
      raise;
    end;
  end;
end;

function TPyPackageManagerPip.IsInstalled(): boolean;
var
  LOpts: TPyPackageManagerDefsOptsPipList;
  LExec: IExecCmd;
begin
  LOpts := BuildOptsList();
  try
    LExec := TExecCmdService
      .Cmd(GetPythonEngine().ProgramName,
        TExecCmdArgs.BuildArgv(
          GetPythonEngine().ProgramName,
          ['-m', 'pip'] + FCmd.BuildListCmd(LOpts)),
        TExecCmdArgs.BuildEnvp(
          GetPythonEngine().PythonHome,
          GetPythonEngine().ProgramName,
          TPath.Combine(GetPythonEngine().DllPath, GetPythonEngine().DllName)))
      .Run([TRedirect.stdout, TRedirect.stderr]);

    if (LExec.Wait() <> EXIT_SUCCESS) then
      raise EPipExecCmdFailed.Create(
        Format('Pip comamnd has failed. %s', [LExec.StdErr.ReadAll().Trim()]), LExec.ExitCode);

    Result := LExec.StdOut.ReadAll().Contains(FDefs.PackageName);
  finally
    LOpts.Free();
  end;
end;

procedure TPyPackageManagerPip.Install(const ACancelation: ICancelation);
var
  LIn: TArray<string>;
  LExec: IExecCmd;
begin
  LIn := ['-m', 'pip']
    + FCmd.BuildInstallCmd((FDefs as TPyPackageManagerDefsPip).InstallOptions);

  LExec := TExecCmdService
    .Cmd(GetPythonEngine().ProgramName,
      TExecCmdArgs.BuildArgv(
        GetPythonEngine().ProgramName,
        LIn),
      TExecCmdArgs.BuildEnvp(
        GetPythonEngine().PythonHome,
        GetPythonEngine().ProgramName,
        TPath.Combine(GetPythonEngine().DllPath, GetPythonEngine().DllName)))
    .Run([TRedirect.stderr]);

  TSpinWait.SpinUntil(function(): boolean begin
    Result := not LExec.IsAlive or ACancelation.IsCancelled;
  end);

  ACancelation.CheckCancelled();

  if (LExec.Wait() <> EXIT_SUCCESS) then
    raise EPipExecCmdFailed.Create(
      Format('Pip command has failed. %s', [LExec.StdErr.ReadAll().Trim()]), LExec.ExitCode);
end;

procedure TPyPackageManagerPip.Uninstall(const ACancelation: ICancelation);
var
  LIn: TArray<string>;
  LExec: IExecCmd;
begin
  LIn := ['-m', 'pip']
    + FCmd.BuildInstallCmd((FDefs as TPyPackageManagerDefsPip).UninstallOptions);

  LExec := TExecCmdService
    .Cmd(GetPythonEngine().ProgramName,
      TExecCmdArgs.BuildArgv(
        GetPythonEngine().ProgramName,
        LIn),
      TExecCmdArgs.BuildEnvp(
        GetPythonEngine().PythonHome,
        GetPythonEngine().ProgramName,
        TPath.Combine(GetPythonEngine().DllPath, GetPythonEngine().DllName)))
    .Run([TRedirect.stderr]);

  TSpinWait.SpinUntil(function(): boolean begin
    Result := not LExec.IsAlive or ACancelation.IsCancelled;
  end);

  ACancelation.CheckCancelled();

  if (LExec.Wait() <> EXIT_SUCCESS) then
    raise EPipExecCmdFailed.Create(
      Format('Pip command has failed. %s', [LExec.StdErr.ReadAll().Trim()]), LExec.ExitCode);
end;

end.

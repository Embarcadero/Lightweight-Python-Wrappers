(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Cmd.Pip.Install'                      *)
(*                                                                        *)
(*                                  Copyright (c) 2021                    *)
(*                                  Lucas Moura Belo - lmbelo             *)
(*                                  lucas.belo@live.com                   *)
(*                                  Brazil                                *)
(*                                                                        *)
(*  Project page:                   https://github.com/lmbelo/P4D_AI_ML   *)
(**************************************************************************)
(*  Functionality:  PyPackage Cmd layer                                   *)
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
unit PyPackage.Manager.Cmd.Pip.Install;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  PyPackage.Manager.Defs.Opts.Pip.Install;

type
  TPyPackageManagerCmdPipInstall = class
  private
    FOpts: TPyPackageManagerDefsOptsPipInstall;
  public
    constructor Create(const ADefs: TPyPackageManagerDefsOptsPipInstall);

    function MakeInstallRequirementCmd: TArray<string>; inline;
    function MakeInstallConstraintCmd: TArray<string>; inline;
    function MakeInstallNoDepsCmd: TArray<string>; inline;
    function MakeInstallPreCmd: TArray<string>; inline;
    function MakeInstallEditableCmd: TArray<string>; inline;
    function MakeInstallTargetCmd: TArray<string>; inline;
    function MakeInstallPlatformCmd: TArray<string>; inline;
    function MakeInstallPythonVersionCmd: TArray<string>; inline;
    function MakeIntallPythonImplementationCmd: TArray<string>; inline;
    function MakeInstallAbiCmd: TArray<string>; inline;
    function MakeInstallUserCmd: TArray<string>; inline;
    function MakeInstallRootCmd: TArray<string>; inline;
    function MakeInstallPrefixCmd: TArray<string>; inline;
    function MakeInstallSrcCmd: TArray<string>; inline;
    function MakeInstallUpgradeCmd: TArray<string>; inline;
    function MakeInstallUpgradeStrategyCmd: TArray<string>; inline;
    function MakeInstallForceReinstallCmd: TArray<string>; inline;
    function MakeInstallIgnoreInstalledCmd: TArray<string>; inline;
    function MakeInstallIgnoreRequiresPythonCmd: TArray<string>; inline;
    function MakeInstallNoBuildIsolationCmd: TArray<string>; inline;
    function MakeInstallUsePe517Cmd: TArray<string>; inline;
    function MakeInstallOptionCmd: TArray<string>; inline;
    function MakeInstallGlobalOptionCmd: TArray<string>; inline;
    function MakeInstallCompileCmd: TArray<string>; inline;
    function MakeInstallNoCompileCmd: TArray<string>; inline;
    function MakeInstallNoWarnScriptLocationCmd: TArray<string>; inline;
    function MakeInstallNoWarnConflictsCmd: TArray<string>; inline;
    function MakeInstallNoBinaryCmd: TArray<string>; inline;
    function MakeInstallOnlyBinaryCmd: TArray<string>; inline;
    function MakeInstallPreferBinaryCmd: TArray<string>; inline;
    function MakeInstallRequireHashesCmd: TArray<string>; inline;
    function MakeInstallProgressBarCmd: TArray<string>; inline;
    function MakeInstallNoCleanCmd: TArray<string>; inline;
    function MakeInstallIndexUrlCmd: TArray<string>; inline;
    function MakeInstallExtraIndexUrlCmd: TArray<string>; inline;
    function MakeInstallNoIndexCmd: TArray<string>; inline;
    function MakeInstallFindLinksCmd: TArray<string>; inline;
  end;

implementation

constructor TPyPackageManagerCmdPipInstall.Create(
  const ADefs: TPyPackageManagerDefsOptsPipInstall);
begin
  FOpts := ADefs;
end;

function TPyPackageManagerCmdPipInstall.MakeInstallAbiCmd: TArray<string>;
begin
  if not FOpts.Abi.IsEmpty() then
    Result := TArray<string>.Create('--abi', FOpts.Abi);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallCompileCmd: TArray<string>;
begin
  if FOpts.Compile then
    Result := TArray<string>.Create('--compile');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallConstraintCmd: TArray<string>;
begin
  if not FOpts.Constraint.IsEmpty() then
    Result := TArray<string>.Create('-c', FOpts.Constraint);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallEditableCmd: TArray<string>;
begin
  if not FOpts.Editable.IsEmpty() then
    Result := TArray<string>.Create('-e', FOpts.Editable);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallExtraIndexUrlCmd: TArray<string>;
begin
  if not FOpts.ExtraIndexUrl.IsEmpty() then
    Result := TArray<string>.Create('--extra-index-url', FOpts.ExtraIndexUrl);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallFindLinksCmd: TArray<string>;
begin
  if not FOpts.FindLinks.IsEmpty() then
    Result := TArray<string>.Create('-f', FOpts.FindLinks);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallForceReinstallCmd: TArray<string>;
begin
  if FOpts.ForceReinstall then
    Result := TArray<string>.Create('--force-reinstall');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallGlobalOptionCmd: TArray<string>;
var
  LList: TList<string>;
  LStr: string;
begin
  LList := TList<string>.Create();
  try
    if FOpts.GlobalOption.Count > 0 then
      for LStr in FOpts.GlobalOption do begin
        LList.Add('--global-option');
        LList.Add(LStr);
      end;
      Result := LList.ToArray();
  finally
    LList.Free();
  end;
end;

function TPyPackageManagerCmdPipInstall.MakeInstallIgnoreInstalledCmd: TArray<string>;
begin
  if FOpts.IgnoreInstalled then
    Result := TArray<string>.Create('-I');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallIgnoreRequiresPythonCmd: TArray<string>;
begin
  if FOpts.IgnoreRequiresPython then
    Result := TArray<string>.Create('--ignore-requires-python');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallIndexUrlCmd: TArray<string>;
begin
  if not FOpts.IndexUrl.IsEmpty() then
    Result := TArray<string>.Create('--index-url', FOpts.IndexUrl);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallOptionCmd: TArray<string>;
var
  LList: TList<string>;
  LStr: string;
begin
  LList := TList<string>.Create();
  try
    if FOpts.InstallOption.Count > 0 then
      for LStr in FOpts.InstallOption do begin
        LList.Add('--install-option');
        LList.Add(LStr);
      end;
      Result := LList.ToArray();
  finally
    LList.Free();
  end;
end;

function TPyPackageManagerCmdPipInstall.MakeInstallNoBinaryCmd: TArray<string>;
begin
  if FOpts.NoBinary then
    Result := TArray<string>.Create('--no-binary');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallNoBuildIsolationCmd: TArray<string>;
begin
  if FOpts.NoBuildIsolation then
    Result := TArray<string>.Create('--no-build-isolation');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallNoCleanCmd: TArray<string>;
begin
  if FOpts.NoClean then
    Result := TArray<string>.Create('--no-clean');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallNoCompileCmd: TArray<string>;
begin
  if FOpts.NoCompile then
    Result := TArray<string>.Create('--no-compile');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallNoDepsCmd: TArray<string>;
begin
  if FOpts.NoDeps then
    Result := TArray<string>.Create('--no-deps');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallNoIndexCmd: TArray<string>;
begin
  if FOpts.NoIndex then
    Result := TArray<string>.Create('--no-index');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallNoWarnConflictsCmd: TArray<string>;
begin
  if FOpts.NoWarnConflicts then
    Result := TArray<string>.Create('--no-warn-conflicts');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallNoWarnScriptLocationCmd: TArray<string>;
begin
  if FOpts.NoWarnScriptLocation then
    Result := TArray<string>.Create('--no-warn-script-location');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallOnlyBinaryCmd: TArray<string>;
begin
  if FOpts.OnlyBinary then
    Result := TArray<string>.Create('--only-binary');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallPlatformCmd: TArray<string>;
begin
  if not FOpts.Platform.IsEmpty() then
    Result := TArray<string>.Create('--platform ', FOpts.Platform);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallPreCmd: TArray<string>;
begin
  if FOpts.Pre then
    Result := TArray<string>.Create('--pre');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallPreferBinaryCmd: TArray<string>;
begin
  if FOpts.PreferBinary then
    Result := TArray<string>.Create('--prefer-binary');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallPrefixCmd: TArray<string>;
begin
  if not FOpts.Prefix.IsEmpty() then
    Result := TArray<string>.Create('--prefix', FOpts.Prefix);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallProgressBarCmd: TArray<string>;
begin
  if FOpts.ProgressBar then
    Result := TArray<string>.Create('--progress-bar', 'on')
  else
    Result := TArray<string>.Create('--progress-bar', 'off');
end;

function TPyPackageManagerCmdPipInstall.MakeIntallPythonImplementationCmd: TArray<string>;
begin
  if not FOpts.PythonImplementation.IsEmpty() then
    Result := TArray<string>.Create('--implementation', FOpts.PythonImplementation);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallPythonVersionCmd: TArray<string>;
begin
  if not FOpts.PythonVersion.IsEmpty() then
    Result := TArray<string>.Create('--python-version', FOpts.PythonVersion);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallRequireHashesCmd: TArray<string>;
begin
  if FOpts.RequireHashes then
    Result := TArray<string>.Create('--require-hashes');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallRequirementCmd: TArray<string>;
begin
  if not FOpts.Requirement.IsEmpty() then
    Result := TArray<string>.Create('-r', FOpts.Requirement);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallRootCmd: TArray<string>;
begin
  if not FOpts.Root.IsEmpty() then
    Result := TArray<string>.Create('--root', FOpts.Root);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallSrcCmd: TArray<string>;
begin
  if not FOpts.Source.IsEmpty() then
    Result := TArray<string>.Create('--src', FOpts.Source);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallTargetCmd: TArray<string>;
begin
  if not FOpts.Target.IsEmpty() then
    Result := TArray<string>.Create('-t ', FOpts.Target);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallUpgradeCmd: TArray<string>;
begin
  if FOpts.Upgrade then
    Result := TArray<string>.Create('-U');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallUpgradeStrategyCmd: TArray<string>;
begin
  if not FOpts.UpgradeStrategy.IsEmpty() then
    Result := TArray<string>.Create('--upgrade-strategy', FOpts.UpgradeStrategy);
end;

function TPyPackageManagerCmdPipInstall.MakeInstallUsePe517Cmd: TArray<string>;
begin
  if FOpts.UsePep517 then
    Result := TArray<string>.Create('--use-pep517');
end;

function TPyPackageManagerCmdPipInstall.MakeInstallUserCmd: TArray<string>;
begin
  if FOpts.User then
    Result := TArray<string>.Create('--user');
end;

end.

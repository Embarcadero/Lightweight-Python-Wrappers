(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Cmd.Pip'                              *)
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
unit PyPackage.Manager.Cmd.Pip;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  PyPackage.Manager.Cmd,
  PyPackage.Manager.Cmd.Intf,
  PyPackage.Manager.Defs.Opts;

type
  TPyPackageManagerCmdPip = class(TPyPackageManagerCmd, IPyPackageManagerCmdIntf)
  private
    //Defs cmds
//    function MakePackageCmd: TArray<string>; inline;
  public
    function BuildInstallCmd(const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
    function BuildUninstallCmd(const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
    function BuildListCmd(const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
  end;

implementation

uses
  PyPackage.Manager.Cmd.Pip.Install,
  PyPackage.Manager.Defs.Opts.Pip.Install,
  PyPackage.Manager.Cmd.Pip.Uninstall,
  PyPackage.Manager.Defs.Opts.Pip.Uninstall,
  PyPackage.Manager.Cmd.Pip.List,
  PyPackage.Manager.Defs.Opts.Pip.List;

{ TPyPackageManagerCmdPip }

function TPyPackageManagerCmdPip.BuildInstallCmd(
  const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
begin
  with TPyPackageManagerCmdPipInstall.Create(AOpts as TPyPackageManagerDefsOptsPipInstall) do
    try
      Result := TArray<string>.Create('install')
        + MakeInstallRequirementCmd()
        + MakeInstallConstraintCmd()
        + MakeInstallNoDepsCmd()
        + MakeInstallPreCmd()
        + MakeInstallEditableCmd()
        + MakeInstallTargetCmd()
        + MakeInstallPlatformCmd()
        + MakeInstallPythonVersionCmd()
        + MakeIntallPythonImplementationCmd()
        + MakeInstallAbiCmd()
        + MakeInstallUserCmd()
        + MakeInstallRootCmd()
        + MakeInstallPrefixCmd()
        + MakeInstallSrcCmd()
        + MakeInstallUpgradeCmd()
        + MakeInstallUpgradeStrategyCmd()
        + MakeInstallForceReinstallCmd()
        + MakeInstallIgnoreInstalledCmd()
        + MakeInstallIgnoreRequiresPythonCmd()
        + MakeInstallNoBuildIsolationCmd()
        + MakeInstallUsePe517Cmd()
        + MakeInstallOptionCmd()
        + MakeInstallGlobalOptionCmd()
        + MakeInstallCompileCmd()
        + MakeInstallNoCompileCmd()
        + MakeInstallNoWarnScriptLocationCmd()
        + MakeInstallNoWarnConflictsCmd()
        + MakeInstallNoBinaryCmd()
        + MakeInstallOnlyBinaryCmd()
        + MakeInstallPreferBinaryCmd()
        + MakeInstallRequireHashesCmd()
        + MakeInstallProgressBarCmd()
        + MakeInstallNoCleanCmd()
        + MakeInstallIndexUrlCmd()
        + MakeInstallExtraIndexUrlCmd()
        + MakeInstallNoIndexCmd()
        + MakeInstallFindLinksCmd()
        + [Defs.PackageName + Defs.PackageVersion];
    finally
      Free();
    end;
end;

function TPyPackageManagerCmdPip.BuildListCmd(
  const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
begin
  with TPyPackageManagerCmdPipList.Create(AOpts as TPyPackageManagerDefsOptsPipList) do
    try
      Result := TArray<string>.Create('list')
        + MakeListOudatedCmd()
        + MakeListUpToDateCmd()
        + MakeListEditableCmd()
        + MakeListLocalCmd()
        + MakeListUserCmd()
        + MakeListPathCmd()
        + MakeListPreCmd()
        + MakeListFormatCmd()
        + MakeListNotRequiredCmd()
        + MakeListExcludeEditableCmd()
        + MakeListIncludeEditableCmd()
        + MakeListExcludeCmd()
        + MakeListIndexUrlCmd()
        + MakeListExtraIndexUrlCmd()
        + MakeListNoIndexCmd()
        + MakeListFindLinkdsCmd();
    finally
      Free();
    end;
end;

function TPyPackageManagerCmdPip.BuildUninstallCmd(
  const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
begin
  with TPyPackageManagerCmdPipUninstall.Create(AOpts as TPyPackageManagerDefsOptsPipUninstall) do
    try
      Result := TArray<string>.Create('uninstall')
        + MakeUninstallRequirementCmd()
        + MakeUninstallConfirmationFlagCmd()
        + [Defs.PackageName];
    finally
      Free();
    end;
end;

//function TPyPackageManagerCmdPip.MakePackageCmd: TArray<string>;
//begin
//  var LVersion: string;
//  if not Defs.PackageVersion.IsEmpty() then
//    LVersion := Defs.PackageVersion
//  else
//    LVersion := String.Empty;
//
//  Result := TArray<string>.Create(Defs.PackageName + LVersion);
//end;

end.

(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Cmd.Conda'                            *)
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
unit PyPackage.Manager.Cmd.Conda;

interface

uses
  System.Classes, System.SysUtils, System.Generics.Collections,
  PyPackage.Manager.Cmd,
  PyPackage.Manager.Cmd.Intf,
  PyPackage.Manager.Defs.Opts;

type
  TPyPackageManagerCmdConda = class(TPyPackageManagerCmd, IPyPackageManagerCmdIntf)
  private
//    function MakePackageCmd: TArray<string>; inline;
  public
    function BuildInstallCmd(const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
    function BuildUninstallCmd(const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
    function BuildListCmd(const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
  end;

implementation

uses
  PyPackage.Manager.Cmd.Conda.Install,
  PyPackage.Manager.Defs.Opts.Conda.Install,
  PyPackage.Manager.Cmd.Conda.Uninstall,
  PyPackage.Manager.Defs.Opts.Conda.Uninstall,
  PyPackage.Manager.Cmd.Conda.List,
  PyPackage.Manager.Defs.Opts.Conda.List;

{ TPyPackageManagerCmdConda }

//function TPyPackageManagerCmdConda.MakePackageCmd: TArray<string>;
//begin
//  var LVersion: string;
//  if not Defs.PackageVersion.IsEmpty() then
//    LVersion := Defs.PackageVersion
//  else
//    LVersion := String.Empty;
//
//  Result := TArray<string>.Create(Defs.PackageName + LVersion);
//end;

function TPyPackageManagerCmdConda.BuildInstallCmd(
  const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
begin
  with TPyPackageManagerCmdCondaInstall.Create(AOpts as TPyPackageManagerDefsOptsCondaInstall) do
    try
      Result := TArray<string>.Create('install')
        + MakeInstallRevisionCmd()
        + MakeInstallFileCmd()
        + MakeInstallNameCmd()
        + MakeInstallPrefixCmd()
        + MakeInstallChannelCmd()
        + MakeInstallUseLocalCmd()
        + MakeInstallOverrideChannelsCmd()
        + MakeInstallRepoDataCmd()
        + MakeInstallStrictChannelPriorityCmd()
        + MakeInstallNoChannelPriorityCmd()
        + MakeInstallNoDepsCmd()
        + MakeInstallOnlyDepsCmd()
        + MakeInstallNoPinCmd()
        + MakeInstallExperimentalSolverCmd()
        + MakeInstallForceReinstallCmd()
        + MakeInstallNoUpdateDepsCmd()
        + MakeInstallUpdateDepsCmd()
        + MakeInstallSatisfiedSkipSolveCmd()
        + MakeInstallUpdateAllCmd()
        + MakeInstallUpdateSpecsCmd()
        + MakeInstallCopyCmd()
        + MakeInstallMkDirCmd()
        + MakeInstallClobberCmd()
        + MakeInstallUseIndexCacheCmd()
        + MakeInstallInsecureCmd()
        + MakeInstallOfflineCmd()
        + MakeInstallDryRunCmd()
        + MakeInstallJsonCmd()
        + MakeInstallQuietCmd()
        + MakeInstallVerboseCmd()
        + MakeInstallDoNotAskForConfirmationCmd()
        + MakeInstallDownloadOnlyCmd()
        + MakeInstallShowChannelUrlsCmd()
    finally
      Free();
    end;
end;

function TPyPackageManagerCmdConda.BuildUninstallCmd(
  const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
begin
  with TPyPackageManagerCmdCondaUninstall.Create(AOpts as TPyPackageManagerDefsOptsCondaUninstall) do
    try
      Result := TArray<string>.Create('remove')
        + MakeUninstallNameCmd()
        + MakeUninstallPrefixCmd()
        + MakeUninstallChannelCmd()
        + MakeUninstallUseLocalCmd()
        + MakeUninstallOverrideChannelsCmd()
        + MakeUninstallRepodataCmd()
        + MakeUninstallAllCmd()
        + MakeUninstallFeaturesCmd()
        + MakeUninstallForceCmd()
        + MakeUninstallNoPinCmd()
        + MakeUninstallExperimentalSolverCmd()
        + MakeUninstallUseIndexCacheCmd()
        + MakeUninstallInsecureCmd()
        + MakeUninstallOfflineCmd()
        + MakeUninstallDryRunCmd()
        + MakeUninstallJsonCmd()
        + MakeUninstallQuietCmd()
        + MakeUninstallVerboseCmd()
        + MakeUninstallYesCmd()
    finally
      Free();
    end;
end;

function TPyPackageManagerCmdConda.BuildListCmd(
  const AOpts: TPyPackageManagerDefsOpts): TArray<string>;
begin
  with TPyPackageManagerCmdCondaList.Create(AOpts as TPyPackageManagerDefsOptsCondaList) do
    try
      Result := TArray<string>.Create('list')
        + MakeListShowChannelUrlsCmd()
        + MakeListCanonicalCmd()
        + MakeListFullNameCmd()
        + MakeListExplicityCmd()
        + MakeListMd5Cmd()
        + MakeListExportCmd()
        + MakeListRevisionsCmd()
        + MakeListNoPipCmd()
        + MakeListNameCmd()
        + MakeListPrefixCmd()
        + MakeListJsonCmd()
        + MakeListVerboseCmd()
        + MakeListQuietCmd();
    finally
      Free();
    end;
end;

end.

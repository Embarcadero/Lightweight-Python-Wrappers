(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Cmd.Conda.Install'                    *)
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
unit PyPackage.Manager.Cmd.Conda.Install;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  PyPackage.Manager.Defs.Opts.Conda.Install;

type
  TPyPackageManagerCmdCondaInstall = class
  private
    FOpts: TPyPackageManagerDefsOptsCondaInstall;
  public
    constructor Create(const ADefs: TPyPackageManagerDefsOptsCondaInstall);

    function MakeInstallRevisionCmd: TArray<string>; inline;
    function MakeInstallFileCmd: TArray<string>; inline;
    function MakeInstallNameCmd: TArray<string>; inline;
    function MakeInstallPrefixCmd: TArray<string>; inline;
    function MakeInstallChannelCmd: TArray<string>; inline;
    function MakeInstallUseLocalCmd: TArray<string>; inline;
    function MakeInstallOverrideChannelsCmd: TArray<string>; inline;
    function MakeInstallRepoDataCmd: TArray<string>; inline;
    function MakeInstallStrictChannelPriorityCmd: TArray<string>; inline;
    function MakeInstallNoChannelPriorityCmd: TArray<string>; inline;
    function MakeInstallNoDepsCmd: TArray<string>; inline;
    function MakeInstallOnlyDepsCmd: TArray<string>; inline;
    function MakeInstallNoPinCmd: TArray<string>; inline;
    function MakeInstallExperimentalSolverCmd: TArray<string>; inline;
    function MakeInstallForceReinstallCmd: TArray<string>; inline;
    function MakeInstallNoUpdateDepsCmd: TArray<string>; inline;
    function MakeInstallUpdateDepsCmd: TArray<string>; inline;
    function MakeInstallSatisfiedSkipSolveCmd: TArray<string>; inline;
    function MakeInstallUpdateAllCmd: TArray<string>; inline;
    function MakeInstallUpdateSpecsCmd: TArray<string>; inline;
    function MakeInstallCopyCmd: TArray<string>; inline;
    function MakeInstallMkDirCmd: TArray<string>; inline;
    function MakeInstallClobberCmd: TArray<string>; inline;
    function MakeInstallUseIndexCacheCmd: TArray<string>; inline;
    function MakeInstallInsecureCmd: TArray<string>; inline;
    function MakeInstallOfflineCmd: TArray<string>; inline;
    function MakeInstallDryRunCmd: TArray<string>; inline;
    function MakeInstallJsonCmd: TArray<string>; inline;
    function MakeInstallQuietCmd: TArray<string>; inline;
    function MakeInstallVerboseCmd: TArray<string>; inline;
    function MakeInstallDoNotAskForConfirmationCmd: TArray<string>; inline;
    function MakeInstallDownloadOnlyCmd: TArray<string>; inline;
    function MakeInstallShowChannelUrlsCmd: TArray<string>; inline;
  end;

implementation

constructor TPyPackageManagerCmdCondaInstall.Create(
  const ADefs: TPyPackageManagerDefsOptsCondaInstall);
begin
  FOpts := ADefs;
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallChannelCmd: TArray<string>;
begin
  if not FOpts.Channel.IsEmpty() then
    Result := TArray<string>.Create('--channel', FOpts.Channel);
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallClobberCmd: TArray<string>;
begin
  if FOpts.Clobber then
    Result := TArray<string>.Create('--clobber');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallCopyCmd: TArray<string>;
begin
  if FOpts.Copy then
    Result := TArray<string>.Create('--copy');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallDoNotAskForConfirmationCmd: TArray<string>;
begin
  if FOpts.DoNotAskForConfirmation then
    Result := TArray<string>.Create('--yes');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallDownloadOnlyCmd: TArray<string>;
begin
  if FOpts.DownloadOnly then
    Result := TArray<string>.Create('--download-only');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallDryRunCmd: TArray<string>;
begin
  if FOpts.DryRun then
    Result := TArray<string>.Create('--dry-run');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallExperimentalSolverCmd: TArray<string>;
begin
  if not FOpts.ExperimentalSolver.IsEmpty() then
    Result := TArray<string>.Create('--experimental-solver', FOpts.ExperimentalSolver);
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallFileCmd: TArray<string>;
var
  LList: TList<string>;
  LStr: string;
begin
  LList := TList<string>.Create();
  try
    for LStr in FOpts.Files do
      LList.Add('--file=' + LStr);
    Result := LList.ToArray();
  finally
    LList.Free();
  end;
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallForceReinstallCmd: TArray<string>;
begin
  if FOpts.ForceReinstall then
    Result := TArray<string>.Create('--force-reinstall');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallNoUpdateDepsCmd: TArray<string>;
begin
  if FOpts.NoUpdateDeps then
    Result := TArray<string>.Create('--no-update-deps');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallInsecureCmd: TArray<string>;
begin
  if FOpts.Insecure then
    Result := TArray<string>.Create('--insecure');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallJsonCmd: TArray<string>;
begin
  if FOpts.Json then
    Result := TArray<string>.Create('--json');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallMkDirCmd: TArray<string>;
begin
  if FOpts.MkDir then
    Result := TArray<string>.Create('--mkdir');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallNameCmd: TArray<string>;
begin
  if not FOpts.Name.IsEmpty() then
    Result := TArray<string>.Create('--name', FOpts.Name);
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallNoChannelPriorityCmd: TArray<string>;
begin
  if FOpts.NoChannelPriority then
    Result := TArray<string>.Create('--no-channel-priority');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallNoDepsCmd: TArray<string>;
begin
  if FOpts.NoDeps then
    Result := TArray<string>.Create('--no-deps');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallNoPinCmd: TArray<string>;
begin
  if FOpts.OnlyDeps then
    Result := TArray<string>.Create('--no-pin');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallOfflineCmd: TArray<string>;
begin
  if FOpts.OffLine then
    Result := TArray<string>.Create('--offline');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallOnlyDepsCmd: TArray<string>;
begin
  if FOpts.OnlyDeps then
    Result := TArray<string>.Create('--only-deps');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallOverrideChannelsCmd: TArray<string>;
begin
  if FOpts.OverrideChannels then
    Result := TArray<string>.Create('--override-channels');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallPrefixCmd: TArray<string>;
begin
  if not FOpts.Prefix.IsEmpty() then
    Result := TArray<string>.Create('--prefix', FOpts.Prefix);
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallQuietCmd: TArray<string>;
begin
  if FOpts.Quiet then
    Result := TArray<string>.Create('--quiet');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallRepoDataCmd: TArray<string>;
var
  LList: TList<string>;
  LStr: string;
begin
  LList := TList<string>.Create();
  try
    for LStr in FOpts.RepoData do begin
      LList.Add('--repodata-fn=' + LStr);
    end;
    Result := LList.ToArray();
  finally
    LList.Free();
  end;
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallRevisionCmd: TArray<string>;
begin
  if not FOpts.Revision.IsEmpty() then
    Result := TArray<string>.Create('--revision', FOpts.Revision);
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallSatisfiedSkipSolveCmd: TArray<string>;
begin
  if FOpts.SatisfiedSkipSolve then
    Result := TArray<string>.Create('--satisfied-skip-solve');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallShowChannelUrlsCmd: TArray<string>;
begin
  if FOpts.ShowChannelUrls then
    Result := TArray<string>.Create('--show-channel-urls');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallStrictChannelPriorityCmd: TArray<string>;
begin
  if FOpts.StrictChannelPriority then
    Result := TArray<string>.Create('--strict-channel-priority');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallUpdateAllCmd: TArray<string>;
begin
  if FOpts.UpdateAll then
    Result := TArray<string>.Create('--all');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallUpdateDepsCmd: TArray<string>;
begin
  if FOpts.UpdateDeps then
    Result := TArray<string>.Create('--update-deps');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallUpdateSpecsCmd: TArray<string>;
begin
  if FOpts.UpdateSpecs then
    Result := TArray<string>.Create('--update-specs');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallUseIndexCacheCmd: TArray<string>;
begin
  if FOpts.UseIndexCache then
    Result := TArray<string>.Create('--use-index-cache');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallUseLocalCmd: TArray<string>;
begin
  if not FOpts.UseLocal then
    Result := TArray<string>.Create('--use-local');
end;

function TPyPackageManagerCmdCondaInstall.MakeInstallVerboseCmd: TArray<string>;
var
  LList: TList<string>;
  LStr: string;
begin
  LList := TList<string>.Create();
  try
    for LStr in FOpts.Verbose do begin
      LList.Add(LStr);
    end;
  finally
    LList.Free();
  end;
end;

end.

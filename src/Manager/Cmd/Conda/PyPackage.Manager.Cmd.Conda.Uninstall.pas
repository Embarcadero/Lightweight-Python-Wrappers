(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Cmd.Conda.Uninstall'                  *)
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
unit PyPackage.Manager.Cmd.Conda.Uninstall;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  PyPackage.Manager.Defs.Opts.Conda.Uninstall;

type
  TPyPackageManagerCmdCondaUninstall = class
  private
    FOpts: TPyPackageManagerDefsOptsCondaUninstall;
  public
    constructor Create(const ADefs: TPyPackageManagerDefsOptsCondaUninstall);

    function MakeUninstallNameCmd: TArray<string>; inline;
    function MakeUninstallPrefixCmd: TArray<string>; inline;
    function MakeUninstallChannelCmd: TArray<string>; inline;
    function MakeUninstallUseLocalCmd: TArray<string>; inline;
    function MakeUninstallOverrideChannelsCmd: TArray<string>; inline;
    function MakeUninstallRepodataCmd: TArray<string>; inline;
    function MakeUninstallAllCmd: TArray<string>; inline;
    function MakeUninstallFeaturesCmd: TArray<string>; inline;
    function MakeUninstallForceCmd: TArray<string>; inline;
    function MakeUninstallNoPinCmd: TArray<string>; inline;
    function MakeUninstallExperimentalSolverCmd: TArray<string>; inline;
    function MakeUninstallUseIndexCacheCmd: TArray<string>; inline;
    function MakeUninstallInsecureCmd: TArray<string>; inline;
    function MakeUninstallOfflineCmd: TArray<string>; inline;
    function MakeUninstallDryRunCmd: TArray<string>; inline;
    function MakeUninstallJsonCmd: TArray<string>; inline;
    function MakeUninstallQuietCmd: TArray<string>; inline;
    function MakeUninstallVerboseCmd: TArray<string>; inline;
    function MakeUninstallYesCmd: TArray<string>; inline;
  end;

implementation

constructor TPyPackageManagerCmdCondaUninstall.Create(
  const ADefs: TPyPackageManagerDefsOptsCondaUninstall);
begin
  FOpts := ADefs;
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallAllCmd: TArray<string>;
begin
  if FOpts.All then
    Result := TArray<string>.Create('--all');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallChannelCmd: TArray<string>;
begin
  if not FOpts.Channel.IsEmpty() then
    Result := TArray<string>.Create('--channel', FOpts.Channel);
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallDryRunCmd: TArray<string>;
begin
  if FOpts.DryRun then
    Result := TArray<string>.Create('--dry-run');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallExperimentalSolverCmd: TArray<string>;
begin
  if FOpts.ExperimentalSolver then
    Result := TArray<string>.Create('--experimental-solver');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallFeaturesCmd: TArray<string>;
begin
  if FOpts.Features then
    Result := TArray<string>.Create('--features');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallForceCmd: TArray<string>;
begin
  if FOpts.Force then
    Result := TArray<string>.Create('--force');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallInsecureCmd: TArray<string>;
begin
  if FOpts.Insecure then
    Result := TArray<string>.Create('--insecure');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallJsonCmd: TArray<string>;
begin
  if FOpts.Json then
    Result := TArray<string>.Create('--json');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallNameCmd: TArray<string>;
begin
  if not FOpts.Name.IsEmpty() then
    Result := TArray<string>.Create('--name', FOpts.Name);
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallNoPinCmd: TArray<string>;
begin
  if FOpts.NoPin then
    Result := TArray<string>.Create('--no-pin');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallOfflineCmd: TArray<string>;
begin
  if FOpts.Offline then
    Result := TArray<string>.Create('--offline');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallOverrideChannelsCmd: TArray<string>;
begin
  if FOpts.OverrideChannels then
    Result := TArray<string>.Create('--override-channels');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallPrefixCmd: TArray<string>;
begin
  if not FOpts.Prefix.IsEmpty() then
    Result := TArray<string>.Create('--prefix', FOpts.Prefix);
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallQuietCmd: TArray<string>;
begin
  if FOpts.Quiet then
    Result := TArray<string>.Create('--quiet');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallRepodataCmd: TArray<string>;
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

function TPyPackageManagerCmdCondaUninstall.MakeUninstallUseIndexCacheCmd: TArray<string>;
begin
  if FOpts.UseIndexCache then
    Result := TArray<string>.Create('--use-index-cache');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallUseLocalCmd: TArray<string>;
begin
  if FOpts.UseLocal then
    Result := TArray<string>.Create('--use-local');
end;

function TPyPackageManagerCmdCondaUninstall.MakeUninstallVerboseCmd: TArray<string>;
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

function TPyPackageManagerCmdCondaUninstall.MakeUninstallYesCmd: TArray<string>;
begin
  if FOpts.DoNotAskForConfirmation then
    Result := TArray<string>.Create('--yes');
end;

end.

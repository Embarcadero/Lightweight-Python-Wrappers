(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Cmd.Conda.List'                       *)
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
unit PyPackage.Manager.Cmd.Conda.List;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  PyPackage.Manager.Defs.Opts.Conda.List;

type
  TPyPackageManagerCmdCondaList = class
  private
    FOpts:  TPyPackageManagerDefsOptsCondaList;
  public
    constructor Create(const AOpts: TPyPackageManagerDefsOptsCondaList);

//    function MakeListRegexCmd: TArray<string>; inline;
    function MakeListShowChannelUrlsCmd: TArray<string>; inline;
    function MakeListCanonicalCmd: TArray<string>; inline;
    function MakeListFullNameCmd: TArray<string>; inline;
    function MakeListExplicityCmd: TArray<string>; inline;
    function MakeListMd5Cmd: TArray<string>; inline;
    function MakeListExportCmd: TArray<string>; inline;
    function MakeListRevisionsCmd: TArray<string>; inline;
    function MakeListNoPipCmd: TArray<string>; inline;
    function MakeListNameCmd: TArray<string>; inline;
    function MakeListPrefixCmd: TArray<string>; inline;
    function MakeListJsonCmd: TArray<string>; inline;
    function MakeListVerboseCmd: TArray<string>; inline;
    function MakeListQuietCmd: TArray<string>; inline;
  end;

implementation

constructor TPyPackageManagerCmdCondaList.Create(
  const AOpts: TPyPackageManagerDefsOptsCondaList);
begin
  FOpts := AOpts;
end;

function TPyPackageManagerCmdCondaList.MakeListCanonicalCmd: TArray<string>;
begin
  if FOpts.Canonical then
    Result := TArray<string>.Create('--canonical');
end;

function TPyPackageManagerCmdCondaList.MakeListExplicityCmd: TArray<string>;
begin
  if FOpts.Explicity then
    Result := TArray<string>.Create('--explicit');
end;

function TPyPackageManagerCmdCondaList.MakeListExportCmd: TArray<string>;
begin
  if FOpts.Export then
    Result := TArray<string>.Create('--export');
end;

function TPyPackageManagerCmdCondaList.MakeListFullNameCmd: TArray<string>;
begin
  if FOpts.FullName then
    Result := TArray<string>.Create('--full-name');
end;

function TPyPackageManagerCmdCondaList.MakeListJsonCmd: TArray<string>;
begin
  if FOpts.Json then
    Result := TArray<string>.Create('--json');
end;

function TPyPackageManagerCmdCondaList.MakeListMd5Cmd: TArray<string>;
begin
  if FOpts.Md5 then
    Result := TArray<string>.Create('--md5');
end;

function TPyPackageManagerCmdCondaList.MakeListNameCmd: TArray<string>;
begin
  if not FOpts.Name.IsEmpty() then
    Result := TArray<string>.Create('--name', FOpts.Name);
end;

function TPyPackageManagerCmdCondaList.MakeListNoPipCmd: TArray<string>;
begin
  if FOpts.NoPip then
    Result := TArray<string>.Create('--no-pip');
end;

function TPyPackageManagerCmdCondaList.MakeListPrefixCmd: TArray<string>;
begin
  if not FOpts.Prefix.IsEmpty() then
    Result := TArray<string>.Create('--prefix', FOpts.Prefix);
end;

function TPyPackageManagerCmdCondaList.MakeListQuietCmd: TArray<string>;
begin
  if FOpts.Quiet then
    Result := TArray<string>.Create('--quiet');
end;

//function TPyPackageManagerCmdCondaList.MakeListRegexCmd: TArray<string>;
//begin
//  if not FDefs.Regex.IsEmpty() then
//    Result := TArray<string>.Create(FDefs.Regex);
//end;

function TPyPackageManagerCmdCondaList.MakeListRevisionsCmd: TArray<string>;
begin
  if FOpts.Revisions then
    Result := TArray<string>.Create('--revisions');
end;

function TPyPackageManagerCmdCondaList.MakeListShowChannelUrlsCmd: TArray<string>;
begin
  if FOpts.ShowChannelUrls then
    Result := TArray<string>.Create('--show-channel-urls');
end;

function TPyPackageManagerCmdCondaList.MakeListVerboseCmd: TArray<string>;
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

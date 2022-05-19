(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Cmd.Pip.List'                         *)
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
unit PyPackage.Manager.Cmd.Pip.List;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections,
  PyPackage.Manager.Defs.Opts.Pip.List;

type
  TPyPackageManagerCmdPipList = class
  private
    FOpts: TPyPackageManagerDefsOptsPipList;
  public
    constructor Create(const AOpts: TPyPackageManagerDefsOptsPipList);

    function MakeListOudatedCmd: TArray<string>; inline;
    function MakeListUpToDateCmd: TArray<string>; inline;
    function MakeListEditableCmd: TArray<string>; inline;
    function MakeListLocalCmd: TArray<string>; inline;
    function MakeListUserCmd: TArray<string>; inline;
    function MakeListPathCmd: TArray<string>; inline;
    function MakeListPreCmd: TArray<string>; inline;
    function MakeListFormatCmd: TArray<string>; inline;
    function MakeListNotRequiredCmd: TArray<string>; inline;
    function MakeListExcludeEditableCmd: TArray<string>; inline;
    function MakeListIncludeEditableCmd: TArray<string>; inline;
    function MakeListExcludeCmd: TArray<string>; inline;
    function MakeListIndexUrlCmd: TArray<string>; inline;
    function MakeListExtraIndexUrlCmd: TArray<string>; inline;
    function MakeListNoIndexCmd: TArray<string>; inline;
    function MakeListFindLinkdsCmd: TArray<string>; inline;
  end;

implementation

{ TPyPackageManagerCmdPipList }

constructor TPyPackageManagerCmdPipList.Create(
  const AOpts: TPyPackageManagerDefsOptsPipList);
begin
  FOpts := AOpts;
end;

function TPyPackageManagerCmdPipList.MakeListEditableCmd: TArray<string>;
begin
  if FOpts.Editable then
    Result := TArray<string>.Create('--editable');
end;

function TPyPackageManagerCmdPipList.MakeListExcludeCmd: TArray<string>;
begin
  if not FOpts.Exclude.IsEmpty() then
    Result := TArray<string>.Create('--exclude', FOpts.IndexUrl);
end;

function TPyPackageManagerCmdPipList.MakeListExcludeEditableCmd: TArray<string>;
begin
  if FOpts.ExcludeEditable then
    Result := TArray<string>.Create('--exclude-editable');
end;

function TPyPackageManagerCmdPipList.MakeListExtraIndexUrlCmd: TArray<string>;
begin
  if not FOpts.ExtraIndexUrl.IsEmpty() then
    Result := TArray<string>.Create('--extra-index-url', FOpts.ExtraIndexUrl);
end;

function TPyPackageManagerCmdPipList.MakeListFindLinkdsCmd: TArray<string>;
begin
  if not FOpts.FindLinks.IsEmpty() then
    Result := TArray<string>.Create('--find-links', FOpts.FindLinks);
end;

function TPyPackageManagerCmdPipList.MakeListFormatCmd: TArray<string>;
begin
  if not FOpts.Format.IsEmpty() then
    Result := TArray<string>.Create('--format', FOpts.Format);
end;

function TPyPackageManagerCmdPipList.MakeListIncludeEditableCmd: TArray<string>;
begin
  if FOpts.IncludeEditable then
    Result := TArray<string>.Create('--include-editable');
end;

function TPyPackageManagerCmdPipList.MakeListIndexUrlCmd: TArray<string>;
begin
  if not FOpts.IndexUrl.IsEmpty() then
    Result := TArray<string>.Create('--index-url', FOpts.IndexUrl);
end;

function TPyPackageManagerCmdPipList.MakeListLocalCmd: TArray<string>;
begin
  if FOpts.Local then
    Result := TArray<string>.Create('--local');
end;

function TPyPackageManagerCmdPipList.MakeListNoIndexCmd: TArray<string>;
begin
  if FOpts.NoIndex then
    Result := TArray<string>.Create('--no-index');
end;

function TPyPackageManagerCmdPipList.MakeListNotRequiredCmd: TArray<string>;
begin
  if FOpts.NotRequired then
    Result := TArray<string>.Create('--not-required');
end;

function TPyPackageManagerCmdPipList.MakeListOudatedCmd: TArray<string>;
begin
  if FOpts.Outdated then
    Result := TArray<string>.Create('--outdated');
end;

function TPyPackageManagerCmdPipList.MakeListPathCmd: TArray<string>;
var
  LList: TList<string>;
  LStr: string;
begin
  LList := TList<string>.Create();
  try
    for LStr in FOpts.Path do begin
      LList.Add('--path=' + LStr);
    end;
    Result := LList.ToArray();
  finally
    LList.Free();
  end;
end;

function TPyPackageManagerCmdPipList.MakeListPreCmd: TArray<string>;
begin
  if FOpts.Pre then
    Result := TArray<string>.Create('--pre');
end;

function TPyPackageManagerCmdPipList.MakeListUpToDateCmd: TArray<string>;
begin
  if FOpts.UpToDate then
    Result := TArray<string>.Create('--uptodate');
end;

function TPyPackageManagerCmdPipList.MakeListUserCmd: TArray<string>;
begin
  if FOpts.User then
    Result := TArray<string>.Create('--user');
end;

end.

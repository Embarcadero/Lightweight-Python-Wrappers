(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Defs.Pip'                             *)
(*                                                                        *)
(*                                  Copyright (c) 2021                    *)
(*                                  Lucas Moura Belo - lmbelo             *)
(*                                  lucas.belo@live.com                   *)
(*                                  Brazil                                *)
(*                                                                        *)
(*  Project page:                   https://github.com/lmbelo/P4D_AI_ML   *)
(**************************************************************************)
(*  Functionality:  PyPackage Defs layer                                  *)
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
unit PyPackage.Manager.Defs.Pip;

interface

uses
  System.Classes,
  PyCore,
  PyPackage.Manager.Defs,
  PyPackage.Manager.Defs.Opts.Pip.Install,
  PyPackage.Manager.Defs.Opts.Pip.Uninstall;

type
  TPyPackageManagerDefsPip = class(TPyPackageManagerDefs)
  private
    FInstallOptions: TPyPackageManagerDefsOptsPipInstall;
    FUninstallOptions: TPyPackageManagerDefsOptsPipUninstall;
    procedure SetInstallOptions(const AOpts: TPyPackageManagerDefsOptsPipInstall);
    procedure SetUninstallOptions(const AOpts: TPyPackageManagerDefsOptsPipUninstall);
  public
    constructor Create(const APackageName: TPyPackageName); override;
    destructor Destroy(); override;
  published
    property InstallOptions: TPyPackageManagerDefsOptsPipInstall read FInstallOptions write SetInstallOptions;
    property UninstallOptions: TPyPackageManagerDefsOptsPipUninstall read FUninstallOptions write SetUninstallOptions;
  end;

implementation

{ TPyPackageManagerDefsPip }

constructor TPyPackageManagerDefsPip.Create(const APackageName: TPyPackageName);
begin
  inherited;
  FInstallOptions := TPyPackageManagerDefsOptsPipInstall.Create();
  FUninstallOptions := TPyPackageManagerDefsOptsPipUninstall.Create();
end;

destructor TPyPackageManagerDefsPip.Destroy;
begin
  FUninstallOptions.Free();
  FInstallOptions.Free();
  inherited;
end;

procedure TPyPackageManagerDefsPip.SetInstallOptions(
  const AOpts: TPyPackageManagerDefsOptsPipInstall);
begin
  FInstallOptions.Assign(AOpts);
end;

procedure TPyPackageManagerDefsPip.SetUninstallOptions(
  const AOpts: TPyPackageManagerDefsOptsPipUninstall);
begin
  FUninstallOptions.Assign(AOpts);
end;

end.

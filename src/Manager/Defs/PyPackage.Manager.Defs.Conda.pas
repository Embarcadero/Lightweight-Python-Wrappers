(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyPackage.Manager.Defs.Conda'                           *)
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
unit PyPackage.Manager.Defs.Conda;

interface

uses
  System.Classes,
  PyCore,
  PyPackage.Manager.Defs,
  PyPackage.Manager.Defs.Opts.Conda.Install,
  PyPackage.Manager.Defs.Opts.Conda.Uninstall;

type
  TPyPackageManagerDefsConda = class(TPyPackageManagerDefs)
  private
    FInstallOptions: TPyPackageManagerDefsOptsCondaInstall;
    FUninstallOptions: TPyPackageManagerDefsOptsCondaUninstall;
    procedure SetInstallOptions(
      const AOpts: TPyPackageManagerDefsOptsCondaInstall);
    procedure SetUninstallOptions(
      const AOpts: TPyPackageManagerDefsOptsCondaUninstall);
  public
    constructor Create(const APackageName: TPyPackageName); override;
    destructor Destroy(); override;
  published
    property InstallOptions: TPyPackageManagerDefsOptsCondaInstall read FInstallOptions write SetInstallOptions;
    property UninstallOptions: TPyPackageManagerDefsOptsCondaUninstall read FUninstallOptions write SetUninstallOptions;
  end;

implementation

{ TPyPackageManagerDefsConda }

constructor TPyPackageManagerDefsConda.Create(
  const APackageName: TPyPackageName);
begin
  inherited;
  FInstallOptions := TPyPackageManagerDefsOptsCondaInstall.Create();
  FUninstallOptions := TPyPackageManagerDefsOptsCondaUninstall.Create();
end;

destructor TPyPackageManagerDefsConda.Destroy;
begin
  FUninstallOptions.Free();
  FInstallOptions.Free();
  inherited;
end;

procedure TPyPackageManagerDefsConda.SetInstallOptions(
  const AOpts: TPyPackageManagerDefsOptsCondaInstall);
begin
  FInstallOptions.Assign(AOpts);
end;

procedure TPyPackageManagerDefsConda.SetUninstallOptions(
  const AOpts: TPyPackageManagerDefsOptsCondaUninstall);
begin
  FUninstallOptions.Assign(AOpts);
end;

end.

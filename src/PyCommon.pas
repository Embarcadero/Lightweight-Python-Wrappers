(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyCommon'    Copyright (c) 2021                         *)
(*                                                                        *)
(*                                  Lucas Moura Belo - lmbelo             *)
(*                                  lucas.belo@live.com                   *)
(*                                  Brazil                                *)
(*                                                                        *)
(*  Project page:                https://github.com/lmbelo/P4D_AI_ML      *)
(**************************************************************************)
(*  Functionality:  PyCommon layer                                        *)
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
unit PyCommon;

interface

uses
  System.Classes,
  PyEnvironment,
  PyEnvironment.Notification,
  PythonEngine;

type
  //P4D AI&ML extension
  TPyCommon = class(TComponent)
  private
    FPythonEngine: TPythonEngine;
    FPyEnvironment: TPyEnvironment;
    procedure SetPyEnvironment(const APyEnvironment: TPyEnvironment);
    procedure SetPythonEngine(const APythonEngine: TPythonEngine);
  protected
    procedure Notification(AComponent: TComponent; AOperation: TOperation); override;
    procedure EngineLoaded(); virtual;
    function IsReady(): boolean; virtual;
  public
    property PyEnvironment: TPyEnvironment read FPyEnvironment write SetPyEnvironment;
    property PythonEngine: TPythonEngine read FPythonEngine write SetPythonEngine;
  end;

  //P4D AI&ML module extension
  TPyCommonCustomModule = class(TPyCommon)
  private
    FPyModuleRef: PPyObject;
  protected
    //https://docs.python.org/3/c-api/import.html?highlight=importmodule#c.PyImport_ImportModule
    procedure ImportModule(const AModuleName: string); overload;
    //https://docs.python.org/3/c-api/import.html?highlight=importmodule#c.PyImport_ImportModule
    procedure ImportModule(const AModuleName, ASubModuleName: string); overload;
  protected
    property PyModuleRef: PPyObject read FPyModuleRef;
  end;

implementation

{ TPyCommon }

procedure TPyCommon.EngineLoaded;
begin
  //
end;

function TPyCommon.IsReady: boolean;
begin
  Result := Assigned(FPythonEngine)
    and FPythonEngine.Initialized;
end;

procedure TPyCommon.Notification(AComponent: TComponent;
  AOperation: TOperation);
begin
  inherited;
  if (AOperation = opRemove) and (AComponent = FPythonEngine) then begin
    FPythonEngine := nil;
  end;
end;

procedure TPyCommon.SetPyEnvironment(const APyEnvironment: TPyEnvironment);
begin
  if (APyEnvironment <> FPyEnvironment) then begin
    if Assigned(FPyEnvironment) then begin
      FPyEnvironment.RemoveFreeNotification(Self);
    end;
    FPyEnvironment := APyEnvironment;
    if Assigned(FPyEnvironment) then begin
      FPyEnvironment.FreeNotification(Self);
      if Assigned(FPyEnvironment.PythonEngine) then
        SetPythonEngine(FPyEnvironment.PythonEngine);
    end;
  end;
end;

procedure TPyCommon.SetPythonEngine(const APythonEngine: TPythonEngine);
begin
  if (APythonEngine <> FPythonEngine) then begin
    if Assigned(FPythonEngine) then
      FPythonEngine.RemoveFreeNotification(Self);
    FPythonEngine := APythonEngine;
    if Assigned(FPythonEngine) then begin
      FPythonEngine.FreeNotification(Self);
      EngineLoaded();
    end;
  end;
end;

{ TPyCommonCustomModule }

procedure TPyCommonCustomModule.ImportModule(const AModuleName,
  ASubModuleName: string);
begin
  FPyModuleRef := PythonEngine.PyImport_ImportModule(PAnsiChar(AnsiString(
    AModuleName
    + '.'
    + ASubModuleName)));
end;

procedure TPyCommonCustomModule.ImportModule(const AModuleName: string);
begin
  FPyModuleRef := PythonEngine.PyImport_ImportModule(PAnsiChar(AnsiString(AModuleName)));
end;

end.

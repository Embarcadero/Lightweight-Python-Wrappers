(**************************************************************************)
(*                                                                        *)
(* Module:  Unit 'PyUtils'          Copyright (c) 2021                    *)
(*                                                                        *)
(*                                  Lucas Moura Belo - lmbelo             *)
(*                                  lucas.belo@live.com                   *)
(*                                  Brazil                                *)
(*                                                                        *)
(*  Project page:                   https://github.com/lmbelo/P4D_AI_ML   *)
(**************************************************************************)
(*  Functionality:  Provide interop functionalities                       *)
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
unit PyUtils;

interface

uses
  System.SysUtils, System.Variants, System.Generics.Collections, PythonEngine,
  VarPyth;

type
  TVarRecArray = array of TVarRec;
  TClosures = class;
  TypeClosure = TFunc<Variant, Variant>;
  TDictItem = TPair<variant, variant>;
  
  TVariantHelper = record helper for variant
  private
    procedure CheckVarPython();
    procedure CheckVarIsArray();
    function GetValues(const AIndex: variant): variant;
    procedure SetValues(const AIndex, AValue: variant);
  public       
    function AsList(): variant; //Created by a VarArrayOf
    function AsTuple(): variant; //Created by a VarArrayOf 
    function GetEnumerator(): TVarPyEnumerateHelper;

    property Values[const AIndex: variant]: variant read GetValues write SetValues;
  end;

  TVarRecArrayHelper = record helper for TVarRecArray
  public    
    function AsList(): variant; inline; //Created by the Collection function
    function AsTuple(): variant; inline; //Created by the Collection function
    function ToVarArray(): variant;
  end;

  TPyEx = class sealed
  private
    class var FInstance: TPyEx;
  private
    FClosures: TClosures;
  private
    constructor Create();
  private
    class procedure Initialize(); inline;
    class procedure Finalize(); inline;
  public
    destructor Destroy(); override;
    //Collection helpers
    class function Collection(const AArgs: array of const): TVarRecArray; static;
    //Tuple
    class function Tuple(const AArgs: array of const): variant; overload; static;
    class function Tuple<T>(const AArgs: TArray<T>): variant; overload; static;
    //List
    class function List(const AArgs: array of const): variant; overload; static;
    class function List<T>(const AArgs: TArray<T>): variant; overload; static;
    //Dictionary helper
    class function Dictionary(const AArgs: array of TPair<variant, variant>): variant; static;
    //Closure helper
    class function Closure(const AFunc: TypeClosure; const APythonEngine: TPythonEngine = nil): variant;
    //Execute a method decorated with the FPU mask
    class procedure ExecuteMasked(const AProc: TProc);
  end;

  TClosure = class
  private
    FPythonEngine: TPythonEngine;
    FModule: TPythonModule;
    FModuleName: string;
    FAnnMethod: TypeClosure;
    function PyMethod(PSelf, Args: PPyObject): PPyObject; cdecl;
  public
    constructor Create(const AModuleName: string; const AFunc: TypeClosure);
    destructor Destroy(); override;

    procedure Initialize();
    procedure Finalize();

    function ToVariant(): variant;

    property PythonEngine: TPythonEngine read FPythonEngine write FPythonEngine;
    property ModuleName: string read FModuleName;
    property Closure: TypeClosure read FAnnMethod;
  end;

  TClosures = class(TObjectList<TClosure>)
  private
    class var FId: integer;
    function CreateId(): integer;
  public
    function Add(const APythonEngine: TPythonEngine; const AFunc: TypeClosure): TClosure; reintroduce;
    procedure Remove(const AModuleName: string); overload;
  end;

implementation

uses
  System.Rtti, PyExceptions;

{ TVariantHelper }

function TVariantHelper.GetEnumerator: TVarPyEnumerateHelper;
begin
  CheckVarPython();
  Result := VarPyIterate(Self);
end;

function TVariantHelper.GetValues(const AIndex: variant): variant;
begin
  if Assigned(GetPythonEngine.PyObject_GetAttrString(
    ExtractPythonObjectFrom(Self), PAnsiChar('Values')))
  and not Assigned(GetPythonEngine().PyErr_Occurred) then
    Result := Self.Values[AIndex]
  else
    Result := Self.GetItem(AIndex)
end;

procedure TVariantHelper.SetValues(const AIndex, AValue: variant);
begin
  if Assigned(GetPythonEngine.PyObject_GetAttrString(
    ExtractPythonObjectFrom(Self), PAnsiChar('Values')))
  and not Assigned(GetPythonEngine().PyErr_Occurred) then
    Self.Values[AIndex] := AValue
  else
    Self.SetItem(AIndex, AValue);
end;

function TVariantHelper.AsList: variant;
begin
  CheckVarIsArray();
  var LElem: PVariant := VarArrayLock(Self);
  try
    var LLen := VarArrayHighBound(Self, 1) - VarArrayLowBound(Self, 1) + 1;
    Result := NewPythonList(LLen);
    for var I := 0 to LLen - 1 do begin
      Result.SetItem(I, LElem^);
      Inc(LElem);
    end;
  finally
    VarArrayUnlock(Self);
  end;
end;

function TVariantHelper.AsTuple: variant;
var      
  LArr: TVarRecArray;
begin
  CheckVarIsArray();
  var LElem: PVariant := VarArrayLock(Self);
  try
    var LLen := VarArrayHighBound(Self, 1) - VarArrayLowBound(Self, 1) + 1;
    Result := NewPythonTuple(LLen);
    for var I := 0 to LLen - 1 do begin
      Result.SetItem(I, LElem^);
      Inc(LElem);
    end;
  finally
    VarArrayUnlock(Self);
  end;
  Result := LArr.AsTuple();
end;

procedure TVariantHelper.CheckVarIsArray;
begin
  if not VarIsArray(Self) then
    raise EVariantNotAnArrayError.Create('Variant is not an array.');
end;

procedure TVariantHelper.CheckVarPython;
begin
  if not VarIsPython(Self) then
    raise EPyVarIsNotPython.Create(ErrVarIsNotPython);
end;

{ TConstArrayHelper }

function TVarRecArrayHelper.AsList: variant;
begin
  Result := VarPythonCreate(Self, stList);  
end;

function TVarRecArrayHelper.AsTuple: variant;
begin
  Result := VarPythonCreate(Self, stTuple);
end;

function TVarRecArrayHelper.ToVarArray: variant;
begin
  Result := VarArrayCreate([0, Length(Self) - 1], varVariant);
  for var I := Low(Self) to High(Self) do begin
    Result[I] := TValue.FromVarRec(Self[I]).AsVariant();
  end;
end;

{ TPyEx }

class procedure TPyEx.Initialize;
begin
  FInstance := TPyEx.Create();
end;

class procedure TPyEx.Finalize;
begin
  FInstance.Free();
end;

constructor TPyEx.Create;
begin
  FClosures := TClosures.Create(true);
end;

destructor TPyEx.Destroy;
begin
  FClosures.Free();
  inherited;
end;

class function TPyEx.Collection(const AArgs: array of const): TVarRecArray;
begin                                                        
  SetLength(Result, Length(AArgs));
  for var I := Low(AArgs) to High(AArgs) do
    Result[I] := AArgs[I];
end;

class function TPyEx.Tuple(const AArgs: array of const): variant;
begin
  Result := VarPythonCreate(AArgs, stTuple);
end;

class function TPyEx.Tuple<T>(const AArgs: TArray<T>): variant;
begin
  var LValues := VarArrayCreate([0, Length(AArgs) - 1], varVariant);
  for var I := Low(AArgs) to High(AArgs) do begin
    LValues[I] := TValue.From<T>(AArgs[I]).AsVariant();
  end;
  Result := LValues.AsTuple();
end;

class function TPyEx.List(const AArgs: array of const): variant;
begin
  Result := VarPythonCreate(AArgs, stList);
end;

class function TPyEx.List<T>(const AArgs: TArray<T>): variant;
begin
  var LValues := VarArrayCreate([0, Length(AArgs) - 1], varVariant);
  for var I := Low(AArgs) to High(AArgs) do begin
    LValues[I] := TValue.From<T>(AArgs[I]).AsVariant();
  end;
  Result := LValues.AsList();
end;

class function TPyEx.Dictionary(const AArgs: array of TPair<variant, variant>): variant;
begin
  Result := NewPythonDict();
  for var LItem in AArgs do begin
    Result.SetItem(LItem.Key, LItem.Value);
  end;
end;

class procedure TPyEx.ExecuteMasked(const AProc: TProc);
begin
  if Assigned(AProc) then begin
    MaskFPUExceptions(true);
    try
      AProc();
    finally
      MaskFPUExceptions(false);
    end;
  end;
end;

class function TPyEx.Closure(const AFunc: TypeClosure;
  const APythonEngine: TPythonEngine = nil): variant;
begin
  var LPythonEngine := APythonEngine;
  if not Assigned(LPythonEngine) then
    LPythonEngine := GetPythonEngine();
  Result := FInstance.FClosures.Add(LPythonEngine, AFunc).ToVariant();
end;

{ TClosure }

function TClosure.ToVariant: variant;
begin
  var LModule := Import(ModuleName);
  Result := LModule.closure;
end;

constructor TClosure.Create(const AModuleName: string; const AFunc: TypeClosure);
begin
  FModuleName := AModuleName;
  FModule := TPythonModule.Create(nil);
  FModule.ModuleName := AnsiString(AModuleName);
  FAnnMethod := AFunc;
end;

destructor TClosure.Destroy;
begin
  FModule.Free();
  inherited;
end;

procedure TClosure.Finalize;
begin
  FModule.Finalize();
end;

procedure TClosure.Initialize;
begin
  FModule.Engine := PythonEngine;
  FModule.AddDelphiMethod('closure', Self.PyMethod, 'Closure assistent.');
  FModule.Initialize();
end;

function TClosure.PyMethod(PSelf, Args: PPyObject): PPyObject; cdecl;
begin
  if Assigned(FAnnMethod) then begin
    Result := ExtractPythonObjectFrom(FAnnMethod(VarPythonCreate(Args)));
    PythonEngine.Py_INCREF(Result);
  end else Result := FPythonEngine.ReturnNone;
end;

{ TClosures }

function TClosures.Add(const APythonEngine: TPythonEngine;
  const AFunc: TypeClosure): TClosure;
begin
  Result := TClosure.Create(Format('p4d_closure_%d', [CreateId()]), AFunc);
  inherited Add(Result);
  Result.PythonEngine := APythonEngine;
  Result.Initialize();
end;

function TClosures.CreateId: integer;
begin
  Inc(FId);
  Result := FId;
end;

procedure TClosures.Remove(const AModuleName: string);
begin
  for var LClosure in Self do begin
    if LClosure.ModuleName = AModuleName then begin
      Remove(LClosure);
    end;
  end;
end;

initialization
  TPyEx.Initialize();

finalization
  TPyEx.Finalize();

end.

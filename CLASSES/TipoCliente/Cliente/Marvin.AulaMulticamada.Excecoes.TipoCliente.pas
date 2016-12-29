{  Arquivo criado automaticamente Gerador Multicamadas
   (Multitiers Generator VERS�O 0.01)
   Data e Hora: 11/10/2016 - 23:02:06
}

unit Marvin.AulaMulticamada.Excecoes.TipoCliente;

interface

uses
  SysUtils,
   { marvin }
  uMRVExcecoesFramework;

type
  EMRVExcecoesTipoCliente = class(EMRVException)
  end;

  EMRVTipoClienteNaoInformado = class(EMRVExcecoesTipoCliente)
  public
    constructor Create; override;
  end;

  EMRVTipoClienteNaoCadastrado = class(EMRVExcecoesTipoCliente)
  public
    constructor Create; override;
  end;

  EMRVTipoClienteJaCadastrado = class(EMRVExcecoesTipoCliente)
  public
    constructor Create; override;
  end;

  EMRVTipoClienteFereIntegridadeReferencial = class(EMRVExcecoesTipoCliente)
  public
    constructor Create; override;
  end;

  EMRVTipoClienteTipoClienteIdInvalido = class(EMRVExcecoesTipoCliente)
  public
    constructor Create; override;
  end;

  EMRVTipoClienteTipoClienteIdTamanhoInvalido = class(EMRVExcecoesTipoCliente)
  public
    constructor Create(ATamanho: Integer); reintroduce; overload; virtual;
  end;

  EMRVTipoClienteDescricaoInvalida = class(EMRVExcecoesTipoCliente)
  public
    constructor Create; override;
  end;

  EMRVTipoClienteDescricaoTamanhoInvalido = class(EMRVExcecoesTipoCliente)
  public
    constructor Create(ATamanho: Integer); reintroduce; overload; virtual;
  end;

  TMRVTipoClienteExceptionFactory = class(TMRVExceptionFactory)
  public
    class function GetException(const AExceptionClassName: string;
      const AMessage: string = ''): EMRVException; override;
  end;

implementation

uses
  System.Classes;

{ EMRVTipoClienteNaoInformado }

constructor EMRVTipoClienteNaoInformado.Create;
begin
  inherited;
  Self.Message := 'TipoCliente n�o informado.';
end;

{ EMRVTipoClienteNaoCadastrado }

constructor EMRVTipoClienteNaoCadastrado.Create;
begin
  inherited;
  Self.Message := 'TipoCliente n�o cadastrado.';
end;

{ EMRVTipoClienteJaCadastrado }

constructor EMRVTipoClienteJaCadastrado.Create;
begin
  inherited;
  Self.Message := 'TipoCliente j� cadastrado.';
end;

{ EMRVTipoClienteFereIntegridadeReferencial }

constructor EMRVTipoClienteFereIntegridadeReferencial.Create;
begin
  inherited;
  Self.Message := 'A exclus�o n�o pode ser feita.'#$D#$A +
    'Ainda existem depend�ncias no banco de dados.';
end;
{ EMRVTipoClienteTipoClienteIdInvalido }

constructor EMRVTipoClienteTipoClienteIdInvalido.Create;
begin
  inherited;
  Self.Message := 'Id do Tipo de Cliente inv�lido.';
end;

{ EMRVTipoClienteTipoClienteIdTamanhoInvalido }

constructor EMRVTipoClienteTipoClienteIdTamanhoInvalido.Create(ATamanho: Integer);
begin
  inherited Create;
  Self.Message := Format('O tamanho do campo %S excede o valor permitido que � de %d caractere(s).',
    ['Id do Tipo de Cliente', ATamanho]);
end;

{ EMRVTipoClienteDescricaoInvalida }

constructor EMRVTipoClienteDescricaoInvalida.Create;
begin
  inherited;
  Self.Message := 'Descri��o inv�lida.';
end;

{ EMRVTipoClienteDescricaoTamanhoInvalido }

constructor EMRVTipoClienteDescricaoTamanhoInvalido.Create(ATamanho: Integer);
begin
  inherited Create;
  Self.Message := Format('O tamanho do campo %S excede o valor permitido que � de %d caractere(s).',
    ['Descri��o', ATamanho]);
end;

{ TMRVExcepitionFactoryTipoCliente }

class function TMRVTipoClienteExceptionFactory.GetException(const
  AExceptionClassName: string; const AMessage: string): EMRVException;
begin
  if AExceptionClassName = 'EMRVExcecoesTipoCliente' then
    Result := EMRVExcecoesTipoCliente.Create(AMessage)
  else if AExceptionClassName = 'EMRVTipoClienteNaoInformado' then
    Result := EMRVTipoClienteNaoInformado.Create(AMessage)
  else if AExceptionClassName = 'EMRVTipoClienteNaoCadastrado' then
    Result := EMRVTipoClienteNaoCadastrado.Create(AMessage)
  else if AExceptionClassName = 'EMRVTipoClienteJaCadastrado' then
    Result := EMRVTipoClienteJaCadastrado.Create(AMessage)
  else if AExceptionClassName = 'EMRVTipoClienteFereIntegridadeReferencial' then
    Result := EMRVTipoClienteFereIntegridadeReferencial.Create(AMessage)
  else if AExceptionClassName = 'EMRVTipoClienteTipoClienteIdInvalido' then
    Result := EMRVTipoClienteTipoClienteIdInvalido.Create(AMessage)
  else if AExceptionClassName = 'EMRVTipoClienteTipoClienteIdTamanhoInvalido' then
    Result := EMRVTipoClienteTipoClienteIdTamanhoInvalido.Create(AMessage)
  else if AExceptionClassName = 'EMRVTipoClienteDescricaoInvalida' then
    Result := EMRVTipoClienteDescricaoInvalida.Create(AMessage)
  else if AExceptionClassName = 'EMRVTipoClienteDescricaoTamanhoInvalido' then
    Result := EMRVTipoClienteDescricaoTamanhoInvalido.Create(AMessage)
  else
    Result := nil;
end;

end.



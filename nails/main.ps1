Add-Type -AssemblyName PresentationFramework;
$arq64=[System.Environment]::Is64BitOperatingSystem;
$arqString=''

if($arq64 -eq $true){
    $arqString='64bits'
}
if($arq64 -ne $true){
    $arqString='32bits'
}

$prob1=$prob2='True'

$q1=[System.Windows.MessageBox]::Show('Ola,
Essa e uma ferramenta para resolucao de travamento na placa de video.
Lembre-se de realizar backup do estado atual!

Desenvolvedor:
    renatorraraujo@gmail.com
    https://github.com/renatoexpert', 
    'Graphics Fixer by @renatoexpert',
'Ok');

$q2=[System.Windows.MessageBox]::Show('Deseja alterar os efeitos graficos do windows, para obter maior perfomance?
Isso ira remover sobras e gradientes, por exemplo.', 'Graphics Fixer - Change Effects',
'YesNo');
$q2h=''

if($q2 -eq 'Yes'){
    [System.Windows.MessageBox]::Show('Você optou por remover os efeitos visuais do windows', 
    'Graphics Fixer - Change Effects',
    'OK');
}
if($q2 -eq 'No'){
    [System.Windows.MessageBox]::Show('Você optou por por manter os efeitos visuais do windows (sem alteração nesse quesito).', 
    'Graphics Fixer - Change Effects',
    'OK');
    $q2h=' NAO'
}

$q3=[System.Windows.MessageBox]::Show('
    Deseja alterar o tempo de espera para a placa de video?
    Isso aumenta a tolerancia a sobrecargas, evitando que o sistema pare', 
    'Graphics Fixer - Driver wait time',
    'YesNo');
$q3h=''

if($q3 -eq 'Yes'){
    [System.Windows.MessageBox]::Show('
    Você optou por alterar o tempo de espera da placa de video.',
    'Graphics Fixer - Driver wait time',
    'OK');
}
if($q3 -eq 'No'){
    [System.Windows.MessageBox]::Show('
    Você optou por por manter as configurações da placa de video (sem alteração nesse quesito).',
    'Graphics Fixer - Driver wait time',
    'OK');
    $q3h=' NAO'
}

$q4=[System.Windows.MessageBox]::Show("
Voce optou por$q2h alterar os efeitos visuais do windows, e
também optou por$q3h alterar as configuracoes do driver de video.
Foi detectado um sistema operacional em arquitetura $arqString.
Confirma?
", 'Graphics Fixer - Confirmacao final',
'YesNo');

if($q4 -eq 'Yes'){
    if($q2 -eq 'Yes'){
        regedit.exe -S .\visu.reg;
        $prob1=$?;
    }
    if($q3 -eq 'Yes'){
        if($arq64 -eq $true){
            regedit.exe -S .\timeout64.reg
            $prob2=$?
        }
        else{
            regedit.exe -S .\timeout32.reg
            $prob2=$?
        }
    }
    if(($prob1 -eq 'True') -and ($prob2 -eq 'True')){
        [System.Windows.MessageBox]::Show("Realizado com sucesso!", 'Graphics Fixer - Sucesso!',
'OK');
    }
    else{
        [System.Windows.MessageBox]::Show("Houve um erro na alteracao dos registros!", 'Graphics Fixer - Falhou!',
'OK');
    exit;
    }
}
if($q4 -eq 'No'){
    $q4=[System.Windows.MessageBox]::Show("Cancelando sem alteracoes", 'Graphics Fixer - Cancelado',
'OK');
    exit;
}

[System.Windows.MessageBox]::Show("Até mais!
Obrigado por utilizar",
'Graphics Fixer - Thank you!',
'OK');


<h1 align="center"> EstacionaCar </h1>

## :clipboard: Descrição do Projeto
<p align="justify">EstacionaCar é um aplicativo com a intenção gerenciar vagas de estacionamentos privados.</p>

<div>
  <img src="https://github.com/GabrielDimaa/estaciona_car/blob/master/prints/home.jpg" width="240px" height="500px"/>
  <img src="https://github.com/GabrielDimaa/estaciona_car/blob/master/prints/info.jpg" width="240px" height="500px"/>
  <img src="https://github.com/GabrielDimaa/estaciona_car/blob/master/prints/form.jpg" width="240px" height="500px"/>
</div>

<div>
  <img src="https://github.com/GabrielDimaa/estaciona_car/blob/master/prints/resume.jpg" width="240px" height="500px"/>
  <img src="https://github.com/GabrielDimaa/estaciona_car/blob/master/prints/info2.jpg" width="240px" height="500px"/>
</div>

## :zap: Funcionalidades
<p align="justify"> 
  A aplicação permite o usuário cadastrar um veículo em uma determinada vaga em seu estacionamento, informando dados do veículo e do proprietário.
  O aplicativo adiciona o veículo na grade de estacionamento, e a partir da inserção ele calcula o tempo de entrada e o tempo de saída quando for solicitado.
  Ao encerrar a ocupação da vaga, é feito um cálculo do tempo de entrada e tempo de saída, gerando um valor de acordo com o consumo do tempo na vaga.
</p>

## :collision: Status do Projeto
Status do Projeto: Concluído :heavy_check_mark:

## :fire: Implementações e Tecnologias
<h3>Widgets e Pubspec</h3>

- > BottomAppBarNavigator (navegação dinâmica)
- > sqflite: ^1.1.5 (banco de dados no próprio celular)
- > IndexedStack (para navegar com Bottom AppBar, semelhante a Fragments no Android Nativo)
- > Timer (função em dart, usado como temporizador na apliacação)
- > GridView.builder (para minha grid de estacionamnetos)
- > fluttericon: ^1.0.7 (ícones específicos, não encontrados no material icons)
- > mask_shifter: ^0.1.0 (lib para máscaras nos inputs)

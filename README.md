# PluviApp

PluviApp é uma aplicação móvel desenvolvida em Flutter para registro de medições de chuva por alunos, como parte de um projeto educacional de monitoramento pluviométrico.

## Objetivo
O objetivo do PluviApp é permitir que estudantes registrem facilmente os dados coletados de pluviômetros, promovendo a educação ambiental e a participação em projetos científicos.

## Funcionalidades
- Tela de login para alunos (qualquer matrícula/senha, por enquanto)
- Cadastro, edição e exclusão de medições de chuva (data e quantidade em mm)
- Listagem das medições em cards organizados
- Persistência local dos dados usando `shared_preferences`
- Mensagens motivacionais e dicas sobre o clima
- Alternância entre modo claro e escuro
- Suporte a dois idiomas: Português (BR) e Espanhol
- Feedback visual ao salvar ou excluir medições

## Tecnologias Utilizadas
- **Flutter** (Dart)
- **shared_preferences** para armazenamento local

## Estrutura do Projeto
```
lib/
	main.dart                # Configuração principal e rotas
	models/
		measurement.dart       # Modelo de Medição
	services/
		storage_service.dart   # Persistência local
	screens/
		login_screen.dart      # Tela de login
		home_screen.dart       # Tela principal
		add_measurement_screen.dart  # Adicionar medição
		edit_measurement_screen.dart # Editar medição
	widgets/
		measurement_card.dart  # Card de medição
		motivational_message.dart # Mensagem motivacional
		language_switcher.dart    # Alternador de idioma
```

## Como Executar
1. Instale o [Flutter](https://flutter.dev/docs/get-started/install) e configure um emulador Android ou dispositivo físico.
2. No terminal, navegue até a pasta do projeto e execute:
	 ```
	 flutter pub get
	 flutter run
	 ```
3. Faça login com qualquer matrícula e senha para acessar o app.

## Limitações e Próximos Passos
- **Integração com banco de dados**: Atualmente, os dados são salvos apenas localmente. O próximo passo é integrar o app a um banco de dados remoto para análise e compartilhamento dos dados coletados.
- **Validação de login**: No futuro, implementar autenticação real para os alunos.
- **Melhorias visuais e novas funcionalidades**: Gráficos, exportação de dados, notificações, etc.

## Contribuição
Este projeto é aberto para contribuições e sugestões!

---

> Projeto educacional - PluviApp © 2025

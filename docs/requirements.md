# Requisitos - InsuGuia Mobile (Protótipo Acadêmico)

Propósito
- Possibilitar que o acadêmico tenha uma interação dialógica com a sociedade envolvendo questões sociais e contemporâneas.

Objetivo do protótipo
- Permitir que os acadêmicos desenvolvam um protótipo de aplicativo móvel em Flutter para apoio à prescrição de insulina em pacientes internados (cenário NÃO CRÍTICO).

Escopo
- Implementar o cenário "Paciente Não Crítico" com regras básicas de cálculo e geração de prescrição sugerida.
- Fornecer cadastro de paciente com: nome, sexo, idade, peso, altura, creatinina e local de internação.
- Gerar sugestão de prescrição (texto/tabela simples): dieta, monitorização, insulina basal, insulina de ação rápida e orientações para hipoglicemia.
- Simular acompanhamento diário (entrada de glicemias) e sugerir ajustes (implementação futura).

Premissas e limitações
- Protótipo acadêmico sem validade clínica. Não use para decisão clínica.
- Regras implementadas são educacionais e devem ser validadas por especialistas.
- Valores e fórmulas são simples e configuráveis no serviço de prescrição.

Requisitos funcionais (prioridade alta)
1. Cadastro de paciente com validação básica.
2. Geração de prescrição sugerida para cenário não crítico.
3. Exibição de prescrição com justificativa das regras (simples).

Requisitos não-funcionais
- App Flutter multiplataforma (Android/iOS).
- Código organizado (models, services, screens, widgets).
- Testes unitários para lógica de cálculo (pelo menos casos principais).

Aceitação
- Ao salvar um paciente válido, o app gera uma prescrição sugerida visível na tela.
- App não deve travar com entradas inválidas (validações simples).

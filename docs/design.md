# Design - InsuGuia Mobile (Protótipo Acadêmico)

Arquitetura do projeto
- models/: classes de domínio (Patient)
- services/: regras de negócio (PrescriptionService)
- screen/: telas do app (cadastro, prescrição, acompanhamento)
- widgets/: componentes reutilizáveis

Fluxo principal
1. Usuário abre app -> Home
2. Navega para cadastro de paciente -> preenche dados mínimos
3. Ao salvar, o app gera uma prescrição sugerida (tela de prescrição)

Regras de cálculo (versão acadêmica)
- Basal: 0.2 UI/kg/dia
- TDD (para cálculo de correção): 0.5 UI/kg/dia
- Fator de correção (Regular): 1500 / TDD
- Alvo glicêmico para não-críticos: 140 mg/dL

Observações
- Todas as regras são simplificadas para fins educativos e podem ser alteradas em `lib/services/prescription_service.dart`.
- Incluir disclaimer visível: "Protótipo acadêmico sem validade clínica".

Próximos passos (sugestões)
- Implementar tela de acompanhamento diário com armazenamento local simples (shared_preferences ou arquivo JSON).
- Adicionar testes unitários para `PrescriptionService`.
- Melhorar UX e validações conforme feedback de usuários.

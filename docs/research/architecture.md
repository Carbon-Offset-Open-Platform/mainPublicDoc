# Building SCOOP: architectural research, design, and planning.

A frist rough overview of how SCOOP could be structured with focus on decoupling and generalization.

![v1](./20240215%20COOP%20architecutre%20overview%20outline.svg)

In this graph, button to top:

1. An cloud of IoT devices keeps collecting data about all participants in the system
1. The signed data will be validated and used to update the digital twin architecture
1. The digital twin are the source of truth for the SCOOP system. The data will also be used interpolate and model data
1. For each jurisdiction and industry section (equal legal situation), one certifier will read the data and issue (mint) tokens according the data provided by the digital twins. These tokens are fungible among each other.
1. There will be carbon positive and negative tokens, i.e. tokens for GHG entering and leaving the atmosphere
1. The tokens will be made public in a ledger that can be read by market participants
1. Brokers can consolidate these tokens into tranches.
1. Financial service providers can, either directly or through brokers access the ledger and buy and sell these tokens.
1. The FSB or broker will be commissioned to neutralize their carbon positive tokens. Which they are required to do according to their local laws.
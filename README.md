<p align="center">
  <img src="./branding/ICON.png" width="180"/>
</p>

<h1 align="center">NPI Protocol</h1>

<p align="center">
  Deterministic • Transparent • GDP-Linked
</p>

<p align="center">
  A token system anchored to global economic output
</p>

---

## Overview

NPI Protocol is a smart contract system on BNB Chain that derives token value from a real-world macroeconomic metric: **global GDP per capita (USD)**.

Instead of relying purely on market speculation, NPI introduces a deterministic pricing model enforced directly on-chain.

---

## Core Concept

```text
Token Price ← Global GDP per Capita (World Bank)
```

The protocol converts publicly available economic data into a programmable and transparent pricing mechanism.

---

## Architecture

### NPIIndex

* Stores GDP value
* Computes the NPI index
* Enforces update constraints (bounds + cooldown)

### NPIToken

* ERC20-compatible token
* Fixed supply
* No minting after deployment

### NPIMarket

* Enables buy/sell operations
* Uses NPIIndex as price source
* Fully on-chain pricing

---

## Key Properties

* Deterministic pricing
* No runtime oracle dependency
* Minimal attack surface
* Transparent data inputs
* Graceful failure (system freezes safely if updates stop)

---

## Data Source

* Source: World Bank (GDP per capita, USD)
* Update frequency: yearly
* Verified manually before submission

---

## Repository Structure

```
contracts/
  NPIIndex.sol
  NPIToken.sol
  NPIMarket.sol

test-contracts/
  NPITestIndex.sol
  NPITestToken.sol
  NPITestMarket.sol

docs/
  Whitepaper.md

branding/
  logo.png
```

---

## Deployment

### Testnet

* Deploy contracts with test parameters
* Simulate trading and GDP updates

### Mainnet

* Deploy using Ledger-controlled wallet
* Initialize with real GDP value
* Provide liquidity (BNB + NPI)

---

## Updating GDP

1. Retrieve latest GDP data
2. Verify correctness
3. Call `updateGDP()` from owner wallet

Constraints:

* Minimum 1-year interval
* Maximum deviation from previous value
* Value validation enforced on-chain

---

## Security Model

* Ownership controlled via hardware wallet (Ledger)
* No private keys stored on VPS
* No frontend dependency required
* Deterministic contract execution

If updates stop, the protocol continues operating with the last valid value.

---

## Limitations

* Depends on external economic data
* Not fully trustless
* Manual updates required

---

## Documentation

* Full whitepaper: `docs/Whitepaper.md`

---

## Status

* Contracts: ready for testing
* Testnet deployment: pending
* Mainnet deployment: planned

---

## License

MIT

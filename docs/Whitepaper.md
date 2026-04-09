# NPI Protocol Whitepaper

## 1. Introduction

NPI Protocol is a deterministic digital asset system designed to anchor token value to a macroeconomic indicator: global GDP per capita (USD).

Unlike traditional cryptocurrencies, which rely on speculative market dynamics, NPI introduces a pricing model derived from publicly available economic data. This approach aims to provide a transparent, predictable, and externally grounded valuation mechanism.

---

## 2. Motivation

Most digital assets lack a fundamental valuation basis. Prices are often driven by speculation, liquidity cycles, or market sentiment.

NPI addresses this by:

* Linking token value to real-world economic output
* Using a globally recognized metric (GDP per capita)
* Enforcing pricing logic on-chain

The objective is not to eliminate volatility entirely, but to provide a **macro-anchored reference value**.

---

## 3. System Overview

The protocol consists of three smart contracts:

### 3.1 NPIIndex

* Stores GDP value
* Computes the NPI index
* Enforces update constraints:

  * Value bounds
  * Maximum deviation
  * Time-based cooldown

### 3.2 NPIToken

* ERC20-compatible token
* Fixed supply
* No minting after deployment

### 3.3 NPIMarket

* Enables token buy/sell operations
* Uses NPIIndex as price source
* Fully deterministic pricing

---

## 4. Pricing Model

The NPI price is derived from GDP using:

```text
NPI Index = (GDP × MULTIPLIER) / BASE
```

Where:

* GDP = global GDP per capita (USD)
* MULTIPLIER = scaling constant (1e18)
* BASE = normalization factor

This ensures compatibility with on-chain precision and ERC20 decimals.

---

## 5. Data Source

The protocol uses:

* Primary source: World Bank GDP per capita (USD)

Characteristics:

* Publicly accessible
* Widely trusted
* Updated annually

---

## 6. Data Update Mechanism

GDP updates are performed manually by the contract owner:

1. Fetch latest data from World Bank
2. Verify correctness
3. Submit via `updateGDP()`

### Constraints:

* Minimum interval: 1 year
* Maximum deviation from previous value
* Value range validation

These constraints prevent:

* Sudden manipulation
* Invalid data injection
* Frequent updates

---

## 7. Security Model

### 7.1 Ownership

* Controlled via hardware wallet (Ledger)
* Transferable via `transferOwnership()`

### 7.2 Attack Surface

The system minimizes risk by:

* Avoiding external runtime dependencies
* Eliminating oracle complexity
* Using deterministic logic

### 7.3 Failure Modes

If updates stop:

* Last valid GDP remains active
* System continues functioning
* No forced failure or corruption

---

## 8. Limitations

* Relies on external economic data
* Not fully trustless (data origin is off-chain)
* Updates require manual execution

These limitations are inherent to any system incorporating real-world data.

---

## 9. Token Economics

Example configuration:

* Total supply: 1,000,000 NPI

Suggested allocation:

* 40% Liquidity
* 30% Reserve
* 20% Treasury
* 10% Team

The protocol does not enforce token distribution; this is defined at deployment.

---

## 10. Market Mechanism

The NPIMarket contract:

* Calculates price from NPIIndex
* Allows direct buy/sell using BNB
* Requires liquidity provisioning

Pricing is:

* Transparent
* Deterministic
* Independent of external exchanges

---

## 11. Long-Term Behavior

The system is designed to:

* Operate indefinitely
* Maintain last known valid state
* Avoid catastrophic failure

If GDP updates cease permanently:

* The index becomes static
* Market behavior continues around fixed value

---

## 12. Future Considerations

Potential extensions:

* Multi-source GDP validation
* Decentralized oracle integration
* Public update participation
* Analytical dashboards

These are optional and not required for core functionality.

---

## 13. Conclusion

NPI Protocol introduces a macroeconomic anchor into digital asset pricing. By combining:

* Public economic data
* Deterministic smart contracts
* Minimal architecture

it provides a transparent and structured alternative to purely speculative token models.

The system prioritizes:

* Simplicity
* Auditability
* Long-term survivability

over unnecessary complexity.

---

## License

MIT

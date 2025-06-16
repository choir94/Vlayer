
# VLAYER DOCKER TUTORIAL (PREBUILT IMAGE)

Supports both Testnet & Mainnet

---

## 1. Pull Docker Image

```bash
docker pull suntani/vlayer-container:latest
```

---

## 2. Run the Container

```bash
docker run -it --name vlayer-dev suntani/vlayer-container:latest
```

---

## 3. Initialize Vlayer Project

Inside the container:

```bash
vlayer init simple --template simple
cd simple
forge build
```

---

## 4. TESTNET SETUP

### a. Create `.env.testnet.local`

```bash
nano .env.testnet.local
```

**Example content:**
```ini
VLAYER_API_TOKEN=eyJ...           # Get from https://dashboard.vlayer.xyz (testnet mode)
EXAMPLES_TEST_PRIVATE_KEY=0x...   # Your testnet wallet private key
CHAIN_NAME=optimismSepolia
JSON_RPC_URL=https://sepolia.optimism.io
```

### b. Install Dependencies

```bash
bun install
```

### c. Run Prove on Testnet

```bash
bun run prove:testnet
```

---

## 5. MAINNET SETUP

### a. Create `.env.mainnet.local`

```bash
nano .env.mainnet.local
```

**Example content:**
```ini
VLAYER_API_TOKEN=eyJ...           # Get from dashboard (production mode)
EXAMPLES_TEST_PRIVATE_KEY=0x...   # Your wallet private key with ETH
CHAIN_NAME=optimism
JSON_RPC_URL=https://mainnet.optimism.io
```

### b. Run Prove on Mainnet

```bash
bun run prove:mainnet
```

---

## 6. Exit & Restart Container

### Exit the container

```bash
exit
```

### Stop the container

```bash
docker stop vlayer-dev
```

### Restart the container

```bash
docker start -ai vlayer-dev
```

---


## References

- [https://dashboard.vlayer.xyz](https://dashboard.vlayer.xyz)
- [https://docs.vlayer.xyz](https://docs.vlayer.xyz)
- [https://t.me/airdrop_node](https://t.me/airdrop_node)
---

This tutorial is suitable for testnet/mainnet proving, zk app exploration, and Vlayer development without local setup.

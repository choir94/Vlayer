#!/bin/bash

clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📧 Email Proof | Script by: Airdrop Node"
echo "🌐 Telegram: https://t.me/airdrop_node"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 1

# Setup awal
vlayerup && vlayer --version

# Inisialisasi jika direktori belum ada
PROJECT_DIR="$HOME/app/simple-email-proof"
if [ ! -d "$PROJECT_DIR" ]; then
  vlayer init simple-email-proof --template simple-email-proof
fi

# Masuk ke direktori project
cd "$PROJECT_DIR" || { echo "❌ Project directory not found."; exit 1; }

forge build
cd vlayer || exit

# Prompt jika file env belum ada
if [ ! -f ".env.testnet.local" ]; then
    echo "🔑 Enter your Testnet JWT API Key:"
    read -rp "→ API Key: " api_key

    echo "🗝️  Enter your Testnet Private Key (0x...):"
    read -rp "→ Private Key: " private_key

    echo ""
    echo "🌍 Select testnet chain (default: optimismSepolia):"
    echo "1) optimismSepolia (default)"
    echo "2) sepolia"
    echo "3) baseSepolia"
    echo "4) polygonAmoy"
    echo "5) arbitrumSepolia"
    echo "6) lineaSepolia"
    echo "7) worldchainSepolia"
    echo "8) zksyncSepoliaTestnet"
    read -rp "→ Chain [1-8]: " chain_choice

    case $chain_choice in
        2) chain="sepolia"; rpc="https://sepolia.infura.io/v3/YOUR_PROJECT_ID";;
        3) chain="baseSepolia"; rpc="https://sepolia.base.org";;
        4) chain="polygonAmoy"; rpc="https://rpc-amoy.polygon.technology";;
        5) chain="arbitrumSepolia"; rpc="https://sepolia.arbitrum.io/rpc";;
        6) chain="lineaSepolia"; rpc="https://rpc.sepolia.linea.build";;
        7) chain="worldchainSepolia"; rpc="https://rpc.sepolia.worldchain.dev";;
        8) chain="zksyncSepoliaTestnet"; rpc="https://sepolia.era.zksync.dev";;
        *) chain="optimismSepolia"; rpc="https://sepolia.optimism.io";;
    esac

    echo ""
    echo "🌐 Default RPC: $rpc"
    echo "🛠️  Do you want to override the RPC URL?"
    read -rp "→ Enter custom RPC (leave blank to use default): " custom_rpc

    if [ -n "$custom_rpc" ]; then
        rpc="$custom_rpc"
    fi

    echo "📦 Writing config to .env.testnet.local ..."
    cat <<EOF > .env.testnet.local
VLAYER_API_TOKEN=$api_key
EXAMPLES_TEST_PRIVATE_KEY=$private_key
CHAIN_NAME=$chain
JSON_RPC_URL=$rpc
EOF
else
    echo "✅ Using existing .env.testnet.local"
fi

# Install SDK dan jalankan
bun add @vlayer/sdk
echo "🚀 Running proof command on $chain ..."
bun run prove:testnet

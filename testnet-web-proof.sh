#!/bin/bash

clear
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🔵 Script by: Airdrop Node | https://t.me/airdrop_node"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
sleep 1

# Jalankan vlayerup dan tampilkan versi
vlayerup && vlayer --version

# Inisialisasi project jika direktori kosong
PROJECT_DIR="$HOME/app/simple-web-proof"
if [ -d "$PROJECT_DIR" ] && [ "$(ls -A $PROJECT_DIR)" ]; then
    echo "⚠️  Directory $PROJECT_DIR already exists and is not empty."
    echo "🛠️  Skipping vlayer init."
else
    vlayer init simple-web-proof --template simple-web-proof
fi

cd simple-web-proof || exit
forge build
cd vlayer || exit

# Cek apakah file env testnet sudah ada
if [ ! -f ".env.testnet.local" ]; then
    echo "🔑 Enter your Testnet JWT API Key:"
    read -rp "→ API Key: " api_key

    echo "🗝️  Enter your Testnet Private Key (0x...):"
    read -rp "→ Private Key: " private_key

    echo ""
    echo "🧪 Select testnet chain (default: optimismSepolia):"
    echo "1) optimismSepolia (default)"
    echo "2) baseSepolia"
    echo "3) sepolia"
    echo "4) polygonAmoy"
    echo "5) arbitrumSepolia"
    echo "6) lineaSepolia"
    echo "7) worldchainSepolia"
    echo "8) zksyncSepoliaTestnet"
    read -rp "→ Chain [1-8]: " chain_choice

    case $chain_choice in
        2) chain="baseSepolia"; default_rpc="https://sepolia.base.org";;
        3) chain="sepolia"; default_rpc="https://rpc.sepolia.org";;
        4) chain="polygonAmoy"; default_rpc="https://rpc-amoy.polygon.technology";;
        5) chain="arbitrumSepolia"; default_rpc="https://sepolia-rollup.arbitrum.io/rpc";;
        6) chain="lineaSepolia"; default_rpc="https://rpc.sepolia.linea.build";;
        7) chain="worldchainSepolia"; default_rpc="https://rpc.sepolia.worldchain.builders";;
        8) chain="zksyncSepoliaTestnet"; default_rpc="https://sepolia.era.zksync.dev";;
        *) chain="optimismSepolia"; default_rpc="https://sepolia.optimism.io";;
    esac

    echo ""
    echo "🌐 Default RPC for $chain: $default_rpc"
    echo "🛠️  Do you want to override the RPC URL?"
    read -rp "→ Enter custom RPC (leave blank to use default): " custom_rpc

    if [ -z "$custom_rpc" ]; then
        rpc="$default_rpc"
    else
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

# Install SDK jika belum
bun add @vlayer/sdk

# Jalankan proof
echo "🚀 Running proof command for testnet on $chain ..."
bun run prove:testnet

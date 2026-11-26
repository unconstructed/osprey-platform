# Osprey platform

The Osprey app and its backend, in one repo: the mobile app now, the admin dashboard and backend services later.
The product plan lives in the lab repo, `unconstructed/osprey`, under `docs/app/` (`README.md`, `features.md`,
`technical.md`, `repos.md`). Read only the parts a task needs.

## Owner's rules (always)

1. **Simplicity wins.** Pick the simplest thing that works. No extra layers, tools or services "for later".
2. **Tokens cost the owner money.** Before launching an agent or any job likely to write more than about 500,000
   tokens or run longer than about 15 minutes, give a rough token estimate and wait for an OK. Do small things
   directly. Read only the files you need.
3. **Test money only for now.** Base Sepolia (testnet) only. No real funds, no mainnet transactions, and nothing
   that costs money (AWS, paid plans, paid APIs) without the owner's OK first.
4. **No secrets in code, chat or logs.** Public config (for example the Privy App ID) goes in app config or
   `.env.example`; real secrets (the Privy App Secret, keys) go in a git-ignored `.env` or a secure store, and the
   mobile app never holds one.
5. **Report back** in plain English, short enough to read on a phone:
   **Tasks run**, **What was done**, **Why**, **Token cost** (used vs. estimate), **Questions for you**
   (numbered, recommendation first), **What's next**.

## Layout

```
osprey-platform/
├── apps/mobile/        # Expo (React Native, TypeScript): iOS and Android
├── packages/shared/    # types shared by the app and, later, the services
└── services/           # later: API, trade router, risk engine, rules (Python), engine (Python)
```

pnpm workspaces. Add a tool only when a task needs it.

## First version (testnet alpha)

Build in this order, one commit per step, each with lint, typecheck and a few unit tests passing:

1. **Skeleton:** the workspace, the Expo app that opens to a home screen, `packages/shared`.
2. **Login and wallet:** Privy login (email) with an embedded wallet on Base Sepolia; show the address and the
   test-ETH and test-USDC balances. Needs the Privy App ID from the owner.
3. **"Hold this mix" screen:** pick a mix of BTC, ETH and USDC, see the current mix against the target, and a
   preview of the trades a rebalance would make. Placeholder prices and balances; no swap is sent.
4. **Placeholder strategy signals:** a fake feed of signals in the schema of `docs/app/technical.md`, shown in
   the app. No real strategy, no trading.

## Running the app

On the owner's Mac: `pnpm install`, then `cd apps/mobile && npx expo start`. Press `i` for the iOS Simulator
(needs Xcode), `a` for the Android emulator, or scan the QR code with Expo Go on a phone on the same Wi-Fi.

## Not here

The lab (data, backtests, strategy approval) stays in `unconstructed/osprey`. Strategy decision code comes from the
lab later as a published Python package, never copied in.

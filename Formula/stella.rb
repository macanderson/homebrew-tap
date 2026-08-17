# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.69 / @SHA_*@ placeholders below with
# the real version and per-target SHA-256 sums of the prebuilt tarballs, then
# commits the result to the tap repo (macanderson/homebrew-tap) as
# Formula/stella.rb. See .github/workflows/release.yml (the `homebrew` job).
#
# Unlike packaging/homebrew/stella.rb (which builds from source with cargo),
# this installs the prebuilt binary directly — no Rust toolchain required.
class Stella < Formula
  desc "Fast, BYOK, model-agnostic terminal coding agent"
  homepage "https://github.com/macanderson/stella"
  # Explicit version is kept intentionally: brew's URL version-scan is fragile
  # for filenames containing arch tokens (x86_64/aarch64), so we pin it.
  version "0.9.69"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.69/stella-0.9.69-aarch64-apple-darwin.tar.gz"
      sha256 "18a559f6804fa75b0a9e83c6d7962f1e6d88d543c7c7c899ac273f5eecf072e4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.69/stella-0.9.69-x86_64-apple-darwin.tar.gz"
      sha256 "72be59273fc1be1f5e3826289063605f7159f1f0ab76883362659d57290a4a99"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.69/stella-0.9.69-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "84c45731e3b4f86641de2622c52fc9bcf75da43e608261a7eb1ce47254c3be6c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.69/stella-0.9.69-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0d50d053c342948c069cb266294477f4fade7788d4f081671a7356d8e742188b"
    end
  end

  # Each tarball unpacks to a single stella-<version>-<target>/ directory that
  # Homebrew descends into automatically, so the binary is at the CWD root.
  def install
    bin.install "stella"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/stella --version")
  end
end

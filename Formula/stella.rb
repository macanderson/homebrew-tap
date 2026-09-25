# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.437 / @SHA_*@ placeholders below with
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
  version "0.9.437"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.437/stella-0.9.437-aarch64-apple-darwin.tar.gz"
      sha256 "5a0b4cae3e1216d4b5f935199725734b8331e3fe1e0f7765d14b75c369b510b0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.437/stella-0.9.437-x86_64-apple-darwin.tar.gz"
      sha256 "d20d66e813cd990c56fe20b850cee6ee4b81da19dd5d0757506115c2372fa569"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.437/stella-0.9.437-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b3c16a8ec377cdbac19c30e389aa061aff07d88b38507411e4100ba37f008dda"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.437/stella-0.9.437-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ef79d0f467d8d0cab86b9b372afa0fffe21e8eaa6269807ebb87333ab2f2114b"
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

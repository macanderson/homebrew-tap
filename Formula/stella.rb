# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.27 / @SHA_*@ placeholders below with
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
  version "0.8.27"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.27/stella-0.8.27-aarch64-apple-darwin.tar.gz"
      sha256 "58cc26a541d223ff37104a0605017f67b7107af70c79a2ac4cfc35b57776e6aa"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.27/stella-0.8.27-x86_64-apple-darwin.tar.gz"
      sha256 "1d69bd22cee468c421caf0d6cdbef0aa2a2675378fa02a5c0568ec5f25680493"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.27/stella-0.8.27-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "bc112615ae8503ba17033b4ce05660460ef635d305799ff20fd0373b1e123a15"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.27/stella-0.8.27-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "52606089cd372a82e09c5ee3158e973e47c34c7636b9dd6400b010cd4fb743e6"
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

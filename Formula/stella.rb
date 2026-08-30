# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.283 / @SHA_*@ placeholders below with
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
  version "0.9.283"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.283/stella-0.9.283-aarch64-apple-darwin.tar.gz"
      sha256 "493d1b2503123da25469a236aa0fd4251fed48307fbc21858ab95810580fa0ec"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.283/stella-0.9.283-x86_64-apple-darwin.tar.gz"
      sha256 "8d2b427c1999e212e2df8319601a98749b3073b945efd2de783cf5e81fa159a0"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.283/stella-0.9.283-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d507649bdd45742e033c5f7509d4aeb08e09b002493fd748ed95b04df1a568eb"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.283/stella-0.9.283-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aefc9e903d00fdd0c5553883103351643bcbc0ee15a49bb07d944b4fb263c6f6"
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

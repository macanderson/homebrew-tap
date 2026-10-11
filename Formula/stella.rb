# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.492 / @SHA_*@ placeholders below with
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
  version "0.9.492"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.492/stella-0.9.492-aarch64-apple-darwin.tar.gz"
      sha256 "ff5600f0e9cd5974a163b78710ccf7dc9e4090e5c72b888afc55f3a166cb97a1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.492/stella-0.9.492-x86_64-apple-darwin.tar.gz"
      sha256 "49d723793c0294972dd897ae8397fb3e1a1a9d3f4d44afaf8af72b0668e4dad2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.492/stella-0.9.492-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "087d99663d9914a23b7de0ba8d3aaa2aa4a45170fd99f40d68caae3e1a669b5e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.492/stella-0.9.492-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bc65990700417e0fe30a2768357594bd5b73d0289ba10802f373b7bd3dca81ac"
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

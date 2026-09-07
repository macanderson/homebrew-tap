# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.401 / @SHA_*@ placeholders below with
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
  version "0.9.401"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.401/stella-0.9.401-aarch64-apple-darwin.tar.gz"
      sha256 "c10a6c0d3e612f66ee869399ead93ac4f53b577d4238829ec90316420e3df49d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.401/stella-0.9.401-x86_64-apple-darwin.tar.gz"
      sha256 "5806ddd6a493f43f7f955ccfaa7edbd29960d33f317dc9ccded1f653c1e82675"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.401/stella-0.9.401-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "290d0e9f3f5718b543a732e4cc8a42f2fa89c95524bf0bf076a18d3eb93d5d17"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.401/stella-0.9.401-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c31875303c5173c34d266fc1f18cd5c8d72136e54a538bfb26f99e886a7b186d"
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

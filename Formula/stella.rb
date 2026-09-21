# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.432 / @SHA_*@ placeholders below with
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
  version "0.9.432"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.432/stella-0.9.432-aarch64-apple-darwin.tar.gz"
      sha256 "7f7e9c2626b157ab401cd90f1e2839e871786272bc02df6f8c063e90d2e6fac4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.432/stella-0.9.432-x86_64-apple-darwin.tar.gz"
      sha256 "be98907369fc9202f44d6d6d02aadb00d938d7649fe3d062f811968fcf5a2487"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.432/stella-0.9.432-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a437df1ceeba0564d0199e19d25463c9f81bb17806e84fa405e013934dba2be9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.432/stella-0.9.432-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fa534fe5c8d26cf323c75a31e5c24dea382a364f8f60003e825d4bc779fb529c"
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

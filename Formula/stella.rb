# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.250 / @SHA_*@ placeholders below with
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
  version "0.9.250"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.250/stella-0.9.250-aarch64-apple-darwin.tar.gz"
      sha256 "f3459a9be4abc65ed457d6c7d1770357e25d0e61c72105145fdfc592774642ed"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.250/stella-0.9.250-x86_64-apple-darwin.tar.gz"
      sha256 "cd4f6029484f568f2ce1c48b6b587ecefe3e5a9d5042d4bc03eacd019c9d35f9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.250/stella-0.9.250-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3e19037f3c7affbc6f0e55276e4578460fcc2570dc1d54817c1dbda713bc37e7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.250/stella-0.9.250-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c2068c01deb3cdf2f69ba6bcba34a3c05b7babb9ea7719beff1e7029e1dae72d"
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

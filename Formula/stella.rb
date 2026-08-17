# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.80 / @SHA_*@ placeholders below with
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
  version "0.9.80"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.80/stella-0.9.80-aarch64-apple-darwin.tar.gz"
      sha256 "52c5e509c51350c29fb5626ba03d541f2b8ef0a554a3ce5518d593437395746c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.80/stella-0.9.80-x86_64-apple-darwin.tar.gz"
      sha256 "c4a05fdd76133c2dada6f89816b4664f35ae5f3952220912a3de26bf33659bb8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.80/stella-0.9.80-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1344020ad22643c16161504b8629741fb705aa5a19e97ede34493d677c2efa98"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.80/stella-0.9.80-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f7bc7c7a9a2693f3b3301fc3c34a496674f125733bd89f64da2173a4e0d9af77"
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

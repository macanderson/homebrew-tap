# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.301 / @SHA_*@ placeholders below with
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
  version "0.9.301"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.301/stella-0.9.301-aarch64-apple-darwin.tar.gz"
      sha256 "9a44e5a9fe3cc5668c5d235ffc5ae8a22e13ed3ae456a6a7beaaa831e4779672"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.301/stella-0.9.301-x86_64-apple-darwin.tar.gz"
      sha256 "0b99693aa17b10f141d49a96d18061a44696b6109c40f60b94b1a540d8c9adb1"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.301/stella-0.9.301-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "98ea2b36276a1610518a995300b77c612a2bea9f760ab7c4ca943c74652a2342"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.301/stella-0.9.301-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2341e874871981cee73a408d23abccc18d0df1e916166898fdfd9de2e43fd4d3"
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

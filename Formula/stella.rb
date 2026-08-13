# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.34 / @SHA_*@ placeholders below with
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
  version "0.9.34"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.34/stella-0.9.34-aarch64-apple-darwin.tar.gz"
      sha256 "7172aceed85c4e7db5f0e1b4cd2018e0eaac6cc575ed003fd92176b3250f4c22"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.34/stella-0.9.34-x86_64-apple-darwin.tar.gz"
      sha256 "482a9c068aaefd6637764192bf7c7cb20fd5507ef1c69ef0ea3ff7e6d79ad100"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.34/stella-0.9.34-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "107e64c92b50400460444c3ae588d8dbabd2a7089ee0176f105c14a74a9bc23e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.34/stella-0.9.34-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d12fa6e2ad8d42e19d07ffd6be75d7c98690652c587f003757d17f4e3097c9bb"
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

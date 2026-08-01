# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.48 / @SHA_*@ placeholders below with
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
  version "0.6.48"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.48/stella-0.6.48-aarch64-apple-darwin.tar.gz"
      sha256 "c7cb2fb3be7abc4f7a65f15a29a8d731d1200b4cb6b013edeb1c161932a311a9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.48/stella-0.6.48-x86_64-apple-darwin.tar.gz"
      sha256 "6aa1c4385a2a2813a1b2a7af8f04ab327f084f5234084b8cb5ce8425ad19ad46"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.48/stella-0.6.48-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2a9826e417df40f36aed9b9c544d9580e3fac9df55ffe343baad9f2721af65d4"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.48/stella-0.6.48-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fc1c39ef8736e76d3745f7e97f894f4468f8fc1866d205d1b03e4cd385748a57"
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

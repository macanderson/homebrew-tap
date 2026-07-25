# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.5.10 / @SHA_*@ placeholders below with
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
  version "0.5.10"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.10/stella-0.5.10-aarch64-apple-darwin.tar.gz"
      sha256 "349878193fe0079d82f92407f0171d37b0cbdd27273478190d61b8315fc5db9b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.10/stella-0.5.10-x86_64-apple-darwin.tar.gz"
      sha256 "37ba97263288be1bbd4d44fa6ee799a532f8678896496d6589e7e441eed4db80"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.5.10/stella-0.5.10-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e08e5140cf33edc829f2d2cce08fedd617cea93d8a6a729cda912ad9d3ef04c5"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.5.10/stella-0.5.10-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a1e14720338f94cad2fc1c3808002a2ade0862dda01014b3731b94ff71c78636"
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

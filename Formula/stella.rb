# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.413 / @SHA_*@ placeholders below with
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
  version "0.9.413"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.413/stella-0.9.413-aarch64-apple-darwin.tar.gz"
      sha256 "6dec688509133543308f880f36b8abbc0ebbb0e6e38ba719cfd8ac715c68c900"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.413/stella-0.9.413-x86_64-apple-darwin.tar.gz"
      sha256 "e3456d9885c0a7c7e6b31b5267b3c7645b743494f8c273da1c59c0ef7a77e507"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.413/stella-0.9.413-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1c323112059cf4b3d515e89bddebb6f63117e0886400b133f21cd88dce7fde73"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.413/stella-0.9.413-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9e2898a2c0f5424d5f9218a8fcc951dd2ead214ab3efec4a40955dec4df25563"
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

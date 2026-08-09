# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.16 / @SHA_*@ placeholders below with
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
  version "0.8.16"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.16/stella-0.8.16-aarch64-apple-darwin.tar.gz"
      sha256 "1216358f2b744ac33a4051c0a1892ac7b39909583559a3b49e8e685dc47c95d6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.16/stella-0.8.16-x86_64-apple-darwin.tar.gz"
      sha256 "ead932c2c427df93180c278e9ca71bd1be09ad083baeae00389ae7c07b60b039"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.16/stella-0.8.16-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "b686cd045d741e06b21d151e05ca8d7cd90bf973146bd2d9fb672c0aefa8adb0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.16/stella-0.8.16-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c8b8d76d12bd7cd36a0c90351f19569647055e33193d984814a1eed1eed761f0"
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

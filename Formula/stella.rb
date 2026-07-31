# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.6.29 / @SHA_*@ placeholders below with
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
  version "0.6.29"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.29/stella-0.6.29-aarch64-apple-darwin.tar.gz"
      sha256 "ac1a6d78c570298f6817b07af4d7d7dd22a6ee320eba7223e6f6a8fa59a6723d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.29/stella-0.6.29-x86_64-apple-darwin.tar.gz"
      sha256 "d70cae0850de76f002d130c6cb0b47c35c51021adb366c3390f3316c7faa7c08"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.6.29/stella-0.6.29-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "208c9c8faad2403e2e6f24c361f4b298b5802920dc1b6625f46729d21d77c55c"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.6.29/stella-0.6.29-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ef35358560b15ec0e9f245e0721d9c3b122f7612a39c35f062e5466db7fdd2b5"
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

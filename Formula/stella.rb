# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.344 / @SHA_*@ placeholders below with
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
  version "0.9.344"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.344/stella-0.9.344-aarch64-apple-darwin.tar.gz"
      sha256 "950873f19261a4328435f14962a037d853a0ce79de252cbc10363164284151f3"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.344/stella-0.9.344-x86_64-apple-darwin.tar.gz"
      sha256 "6843a4018ddc1a0a876b220450491729ea2df60bf5b6d28ebe2983caf8af5c83"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.344/stella-0.9.344-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3b08c0e20e8b76a9c88328ffa984fd2e31f1e1d39e28804653bfeb110082d537"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.344/stella-0.9.344-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f62945501fa316f60603b987b97bb2f83d4b2e8913152b82d81bdeee2f621302"
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

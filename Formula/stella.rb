# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.116 / @SHA_*@ placeholders below with
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
  version "0.9.116"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.116/stella-0.9.116-aarch64-apple-darwin.tar.gz"
      sha256 "3a12fd4c1f121efe9065a3f2642859a9b1b2569331a1d5ea8ddeba22a0b897f9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.116/stella-0.9.116-x86_64-apple-darwin.tar.gz"
      sha256 "ecf88e119eade3eb0bc91faf1129505ec479d2770141423a75ad61b240b4ca3e"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.116/stella-0.9.116-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f366bac33a54ce07bf8ed4f73e154485c22b0285f9709f8c261e7aaa59475cd7"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.116/stella-0.9.116-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c6529c49238f93227037c36de30391ed996363eb5e03f76894563ee8b7b27c10"
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

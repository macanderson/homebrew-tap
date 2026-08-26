# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.234 / @SHA_*@ placeholders below with
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
  version "0.9.234"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.234/stella-0.9.234-aarch64-apple-darwin.tar.gz"
      sha256 "7e185b2ab63fff34a15d696387318029d0bb2cbcca5ebe4d1bf1273c918c703a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.234/stella-0.9.234-x86_64-apple-darwin.tar.gz"
      sha256 "77e665892bf8e7af48918e249cc94eea457cd1dba163cce3185eb6a15d9e06b7"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.234/stella-0.9.234-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "73f5419e2f6e34d347ce07792bffff9c62363c6efc93620b8b4323e50a16fd7b"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.234/stella-0.9.234-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a5e2d797b1abdfe70dce8db49cb41820b26e57cce1b56af5f9180004405cc0df"
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

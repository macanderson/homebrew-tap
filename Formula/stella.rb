# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.191 / @SHA_*@ placeholders below with
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
  version "0.9.191"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.191/stella-0.9.191-aarch64-apple-darwin.tar.gz"
      sha256 "c790fb874fa99ce98384d0286242afc6f7ce3fbde8329cb5bdb3abf74f78eca1"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.191/stella-0.9.191-x86_64-apple-darwin.tar.gz"
      sha256 "11375a50722c90014b1122c6e1a711a1365bf975f595c3e5652ef3ac01fdc25f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.191/stella-0.9.191-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fa6ba3de23b717ebebd9973e69c846a48d4bc046610833da22a1db5dc9827396"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.191/stella-0.9.191-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "12b468899ae0f187073174baef733848c7aa58c4420fe572e2ca67d3ccc6fe24"
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

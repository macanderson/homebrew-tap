# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.7.32 / @SHA_*@ placeholders below with
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
  version "0.7.32"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.32/stella-0.7.32-aarch64-apple-darwin.tar.gz"
      sha256 "dbba1a07ede1e1962a448045ec2edb77888c457e241186a6195b194d92738102"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.32/stella-0.7.32-x86_64-apple-darwin.tar.gz"
      sha256 "122ed7fed887ab8bdbe1457bf05fd259cea4a0f73bc0fa1c4d7b8335e3cd8374"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.7.32/stella-0.7.32-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9d9162e0aeba30b2eb82e7140204e5a1fc11eb3f0adf4c1dbc2fe9488e37da44"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.7.32/stella-0.7.32-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "01a997f8e10d4a66bfb7faa9346db5c554c0829ffe470945896c4349b1d806f1"
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

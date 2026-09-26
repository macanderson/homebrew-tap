# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.441 / @SHA_*@ placeholders below with
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
  version "0.9.441"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.441/stella-0.9.441-aarch64-apple-darwin.tar.gz"
      sha256 "aa07fc8bde88dbf66d9138aeda78fb86a1e132c733248ec0ccae1cca33bbb26a"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.441/stella-0.9.441-x86_64-apple-darwin.tar.gz"
      sha256 "8b82fe33e77e16797be4ea4f98a1be97a4f92eb77d3f0625597122b1fb5ce3a3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.441/stella-0.9.441-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "2aa010353824808e4225d48284fe472dcec752883018d0cd1e3876a42603d885"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.441/stella-0.9.441-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "96700a2e6b8d065c632199e80ec8dd515a29aa60bc01c8e3df79a3a3310a1334"
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

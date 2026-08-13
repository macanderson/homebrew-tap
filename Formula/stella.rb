# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.25 / @SHA_*@ placeholders below with
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
  version "0.9.25"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.25/stella-0.9.25-aarch64-apple-darwin.tar.gz"
      sha256 "932ac5cc3bfb2dc6e40aae0b565c3b14846bacd6f1bb8f9b24203e7cdfc0c7d9"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.25/stella-0.9.25-x86_64-apple-darwin.tar.gz"
      sha256 "514ceb16407530beefd491892f52927edbc1be044dca2b1a7dfb7c56f8b1183d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.25/stella-0.9.25-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "91f8534f2e07cd34de5041dc6bf4424047d5be4c047123e9b70572dbe6135aad"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.25/stella-0.9.25-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4d31b6c057ad745647c18ff24d0f449d492b80de118353d5242e79f31ddf9192"
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

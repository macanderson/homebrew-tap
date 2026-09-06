# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.367 / @SHA_*@ placeholders below with
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
  version "0.9.367"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.367/stella-0.9.367-aarch64-apple-darwin.tar.gz"
      sha256 "49d243ae1c8f3ef62eac5a61e2c2ba2b038d9cb64ab6ff89316df5394ba655d0"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.367/stella-0.9.367-x86_64-apple-darwin.tar.gz"
      sha256 "0e4424c37fde97f8305788fd3c147ea5a5ace9c244a587257f339044cf3fc20b"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.367/stella-0.9.367-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "dbb22d64f403ebd9df3df2737c94ddd1bef36d2eb7734060789eee0c36b8556d"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.367/stella-0.9.367-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2a8c975c76ed2b37a081b0de0e763c04f81ab8415520312c8fb927bc4624c1e8"
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

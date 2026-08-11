# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.40 / @SHA_*@ placeholders below with
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
  version "0.8.40"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.40/stella-0.8.40-aarch64-apple-darwin.tar.gz"
      sha256 "db49158d6842a69cac7bdc23bf8c3c3c0806c73d45dda44111471b465b0ba781"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.40/stella-0.8.40-x86_64-apple-darwin.tar.gz"
      sha256 "ad42577f740dc6c8452ccc0bef9fe8464009161b52c7e733ad86ec596ff125f9"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.40/stella-0.8.40-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "043d3d26c4b78e079757a1a5e6733b4afbb06a35a2f7fcdf3538b9d206838187"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.40/stella-0.8.40-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b0ec29285cd6f33f4e0ee3ba3bff75a9c52263a24daa2a0b0736a71663daa908"
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

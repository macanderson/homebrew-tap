# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.489 / @SHA_*@ placeholders below with
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
  version "0.9.489"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.489/stella-0.9.489-aarch64-apple-darwin.tar.gz"
      sha256 "f7fdbe13de4b115bed3b68e58c4b6c15560bffe6c107e354dbc87b0b35287e17"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.489/stella-0.9.489-x86_64-apple-darwin.tar.gz"
      sha256 "a7bc40d9f12df4bc2ec4ad1396eb95e49ef4dddbbe788565ba02f91e5dc580ad"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.489/stella-0.9.489-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "a927134ee9204d9bc31a82eb1381e532bb3053a2fcb124819b7b79542518c515"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.489/stella-0.9.489-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "bba0306f4cc7acd818001a20eb370cc43eec51029595b0d29299458903507545"
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

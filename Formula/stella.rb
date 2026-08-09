# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.8.5 / @SHA_*@ placeholders below with
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
  version "0.8.5"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.5/stella-0.8.5-aarch64-apple-darwin.tar.gz"
      sha256 "6399b509438879e7900966974891b1eab50cedced91096d9cd55f4719493667f"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.5/stella-0.8.5-x86_64-apple-darwin.tar.gz"
      sha256 "eec4feab09000efb7818e571832d2fa349b0225005010d6f4bdb42c582712f5d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.8.5/stella-0.8.5-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "710ffa1e52b98edf934c57617566f398e1699ede5517779c1bd02d0b6370cae6"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.8.5/stella-0.8.5-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "368979ec035a1c1d63190dee2e1f7d4cb55d6da52afab9afa8303bb1146f788b"
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

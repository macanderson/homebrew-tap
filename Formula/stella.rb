# Homebrew formula template for the Stella CLI.
#
# This is NOT a hand-maintained formula — the `release` workflow renders it on
# every tag push by substituting the 0.9.160 / @SHA_*@ placeholders below with
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
  version "0.9.160"
  license "AGPL-3.0-only"

  on_macos do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.160/stella-0.9.160-aarch64-apple-darwin.tar.gz"
      sha256 "53769ada37ce6089235b8d0e263addb91aded2b18f5929d7965530387274ad6e"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.160/stella-0.9.160-x86_64-apple-darwin.tar.gz"
      sha256 "6b8aac0f6a966998af07166c394e1292996d7a947fcfc63bb4ccf9e183d8be2f"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/macanderson/stella/releases/download/v0.9.160/stella-0.9.160-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "d00c0a51ed476dd16a4f64945291407250df5502cd3bb38600f425b85c76e039"
    end
    on_intel do
      url "https://github.com/macanderson/stella/releases/download/v0.9.160/stella-0.9.160-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4f8160d91b7e0ae04c468c6e27be0bd1132a7044684270e65ab0f9db7b1834e8"
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
